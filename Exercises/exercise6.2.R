library(RMySQL)
dbUCSClive <- dbConnect(MySQL(), 
                        user = 'genomep',
                        password = 'password',
                        dbname = 'hg38', 
                        host = 'genome-euro-mysql.soe.ucsc.edu',
                        port = 3306)

# Search for all cadherin transcripts (with name2 = CDH*) in the refGene table 
# of the hg38 database (UCSC)
# SELECT * FROM refGene WHERE name2 LIKE 'CDH%'
rsUCSClive = dbSendQuery(dbUCSClive, "SELECT * FROM refGene WHERE name LIKE 'NM_%' AND name2 LIKE 'CDH%'")
dataRefGene <- fetch(rsUCSClive, n=Inf)

# Save RefSeq transcript accession no. (name) and gene symbols (name2) in a dataframe.
# what are the different human CDH gene symbols?
df <- dataRefGene[,c("name", "name2")]
unique(df$name2)
length(unique(df$name2))
