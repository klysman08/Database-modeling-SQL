-- List the title and year of production of the productions for which the person "Michael J. Fox" is known.
SELECT titulo_principal, ano_prod, nome as conhecido
FROM "prod", "partic", "pessoa"
WHERE "prod".id_prod = "partic".id_prod and 
"pessoa".id_pessoa = "partic".id_pessoa and nome LIKE '%Michael J. Fox%';
