-- start src: http://rachbelaid.com/postgres-full-text-search-is-good-enough/
-- build the document
/*
SELECT to_tsvector(name) || to_tsvector(description) as document 
FROM monthly_issues 
; 
*/

-- search 
SELECT id, 'monthly_issues' as table_name , name , ts_rank(to_tsvector(name || description), to_tsquery('search')) as relevancy
FROM monthly_issues 
WHERE 1=1 
AND ts_rank(to_tsvector(name || description), to_tsquery('search')) <> 0
UNION
SELECT id, 'yearly_issues' as table_name , name , ts_rank(to_tsvector(name || description), to_tsquery('search')) as relevancy
FROM yearly_issues 
WHERE 1=1 
AND ts_rank(to_tsvector(name || description), to_tsquery('search')) <> 0
ORDER BY relevancy desc
; 

-- stop  src: http://rachbelaid.com/postgres-full-text-search-is-good-enough/



/*
SELECT setweight(to_tsvector('english', COALESCE(name,'')), 'A') ||  
     setweight(to_tsvector('english', COALESCE(description,'')), 'A')
FROM monthly_issues 
;
DROP MATERIALIZED VIEW mvw_monthly_issues
;
CREATE MATERIALIZED VIEW mvw_monthly_issues
AS
SELECT id, to_tsvector(concat_ws(' ', name, description)) AS tsv_monthly_issues
FROM monthly_issues
;
SELECT * FROM mvw_monthly_issues WHERE tsv_monthly_issues @@ plainto_tsquery('search')
;
*/
/*
SELECT to_tsvector('english', name || description)  
FROM monthly_issues 
*/
; 
/*
WITH
    q AS ( SELECT plainto_tsquery('English', 'create') AS query ),
    d AS ( SELECT (name || ' ' || description) AS document FROM monthly_issues ),
    t AS ( SELECT to_tsvector('English', d.document) AS textsearch FROM d ),
    r AS ( SELECT ts_rank_cd(t.textsearch, q.query) AS rank FROM t, q )
SELECT monthly_issues.name , ts_headline('English', d.document, q.query) AS matches
FROM monthly_issues, q, d, t , r
WHERE q.query @@ t.textsearch 
ORDER BY r.rank DESC 
LIMIT 5;
*/
