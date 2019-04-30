SELECT setweight(to_tsvector('english', COALESCE(name,'')), 'A') ||  
     setweight(to_tsvector('english', COALESCE(description,'')), 'A')
FROM monthly_issues 
;
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
