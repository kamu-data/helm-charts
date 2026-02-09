.PHONY: update-values-schemas
update-values-schemas:
	rust-script -c tools/update_values_schemas.rs

.PHONY: fmt
fmt:
	rustfmt --edition 2024 tools/update_values_schemas.rs
