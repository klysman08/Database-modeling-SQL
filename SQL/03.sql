-- Select all TV series episodes produced between 1990 and 1999, listing the series title, episode title, season, season episode number, year of production, and episode length.
SELECT prod.titulo_principal, prod.titulo_original, 
episodio.temporada, episodio.episodio, prod.ano_prod, prod.tempo_minutos
FROM "prod", "episodio"
WHERE prod.id_prod = episodio.id_prod and prod.ano_prod > 1989 and prod.ano_prod < 2000;
