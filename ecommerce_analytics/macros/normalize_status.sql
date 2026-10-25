{% macro normalize_status(column_name) %}

    LOWER(TRIM({{ column_name }}))

{% endmacro %}