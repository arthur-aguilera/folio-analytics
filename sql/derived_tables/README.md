FOLIO Reporting Derived Tables
==============================

These queries create "derived tables" which are helper tables to
simplify writing ad hoc queries.

The tables are created in the schema `folio_reporting`.  For security
reasons, we suggest creating a separate database user, for example
`ldpreport`, and granting permissions for that user to create tables
only in the schema `folio_reporting`.

Before running the queries for the first time, the schema should be
created:

```sql
CREATE SCHEMA IF NOT EXISTS folio_reporting;

ALTER SCHEMA folio_reporting OWNER TO ldpadmin;

GRANT CREATE, USAGE ON SCHEMA folio_reporting TO ldpreport;

GRANT USAGE ON SCHEMA folio_reporting TO ldp;
```

There are various ways the queries can be executed.  One method is:

```shell
cd folio-analytics/sql/derived_tables
git checkout 0.9-release
git pull
for f in $( ls *.sql ); do
    echo ""
    echo "======== $f ========"
    echo ""
    cat $f > tmpfile
    echo "GRANT SELECT ON ALL TABLES IN SCHEMA folio_reporting TO ldp;" >> tmpfile
    psql ldp -U ldpreport -a -1 -f tmpfile
done
```

The queries should be rerun every night after the LDP full update
completes, so that the derived tables will be recreated with the
latest data.

