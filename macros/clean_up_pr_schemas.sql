{% macro clean_up_pr_schemas(database) %}
    {%- set get_pr_schemas_sql -%}
        use database {{ database }};
        show schemas like 'dbt_cloud_pr_%';
    {%- endset -%}

    {%- set results = run_query(get_pr_schemas_sql) -%}

    {%- if execute -%}
        {%- for schema in results -%}

            {%- set drop_schema_sql -%}
                drop schema if exists {{ schema['name'] }}
            {%- endset -%}
            
            {{ drop_schema_sql }};
            {% do run_query(drop_schema_sql) %}

        {%- endfor -%}
    {%- endif -%}
{% endmacro %}
