DROP TABLE IF EXISTS folio_reporting.instance_formats;

CREATE TABLE folio_reporting.instance_formats AS
WITH instances AS (
    SELECT
        id,
        hrid,
        json_array_elements_text(json_extract_path(data, 'instanceFormatIds')) AS instance_format_id
    FROM
        inventory_instances
)
SELECT
    instances.id AS instance_id,
    instances.hrid AS instance_hrid,
    instances.instance_format_id AS format_id,
    formats.code AS format_code,
    formats.name AS format_name,
    formats.source AS format_source
FROM
    instances
    LEFT JOIN inventory_instance_formats AS formats ON instances.instance_format_id = formats.id;

CREATE INDEX ON folio_reporting.instance_formats (instance_id);

CREATE INDEX ON folio_reporting.instance_formats (instance_hrid);

CREATE INDEX ON folio_reporting.instance_formats (format_id);

CREATE INDEX ON folio_reporting.instance_formats (format_code);

CREATE INDEX ON folio_reporting.instance_formats (format_name);

CREATE INDEX ON folio_reporting.instance_formats (format_source);

