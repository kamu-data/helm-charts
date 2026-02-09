#!/usr/bin/env rust-script
//! ```cargo
//! [dependencies]
//! color-eyre = "*"
//! serde_json = "*"
//! serde_yaml_ng = "*"
//! reqwest = { version = "*", features = ["json"] }
//! tokio = { version = "*", features = ["macros", "rt-multi-thread"] }
//! ```

async fn update_values_schema(chart_name: &str, schema_url_tpl: &str) -> color_eyre::Result<()> {
    let chart: serde_yaml_ng::Value = serde_yaml_ng::from_str(&std::fs::read_to_string(format!(
        "charts/{chart_name}/Chart.yaml"
    ))?)?;
    let app_version = chart["appVersion"].as_str().unwrap();

    let config_schema_url = schema_url_tpl.replace("{app_version}", app_version);

    eprintln!("Downloading config schema for {chart_name} v{app_version}");
    eprintln!("GET {config_schema_url}");

    let mut config_schema: serde_json::Value = reqwest::get(config_schema_url)
        .await?
        .error_for_status()?
        .json()
        .await?;

    let obj = config_schema.as_object_mut().unwrap();
    obj.remove("$schema").expect("$schema should be present");
    obj.remove("title").expect("title should be present");
    let defs = obj.remove("$defs").expect("$defs should be present");

    let mut values_schema: serde_json::Value = serde_json::from_str(&std::fs::read_to_string(
        format!("charts/{chart_name}/values.schema.json"),
    )?)?;

    values_schema["$defs"] = defs;
    values_schema["properties"]["app"]["properties"]["config"] = config_schema;

    let values_schema = serde_json::to_string_pretty(&values_schema)?;
    std::fs::write(
        format!("charts/{chart_name}/values.schema.json"),
        values_schema,
    )?;

    eprintln!("Patched values schema for {chart_name}");
    Ok(())
}

#[tokio::main]
async fn main() -> color_eyre::Result<()> {
    update_values_schema(
        "kamu-api-server",
        "https://raw.githubusercontent.com/kamu-data/kamu-node/refs/tags/v{app_version}/resources/api-server/config-schema.json",
    ).await?;

    update_values_schema(
        "kamu-oracle-provider",
        "https://raw.githubusercontent.com/kamu-data/kamu-node/refs/tags/v{app_version}/resources/oracle-provider/config-schema.json",
    ).await?;

    Ok(())
}
