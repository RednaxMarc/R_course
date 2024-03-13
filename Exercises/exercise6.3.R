library(RMySQL)
# Now connect to the UCSC MySQL database hg19
dbUCSClive <- dbConnect(MySQL(), 
                        user = 'genomep',
                        password = 'password',
                        dbname = 'hg19', 
                        host = 'genome-euro-mysql.soe.ucsc.edu',
                        port = 3306)
# Look at the tables in hg19. Can you find the Ensembl tables (“ens”)?
dbUCSClive_tables <- dbListTables(dbUCSClive)
grep("ens",dbUCSClive_tables, perl=TRUE, value=TRUE)

# Get all records in from the ensGene table in a dataframe dataENS
rsUCSClive = dbSendQuery(dbUCSClive, "SELECT * FROM ensGene")
dataEns <- fetch(rsUCSClive, n=Inf)

# Give the the first 10 rows and 8 columns.
dataEns[1:10,1:8]

# Give the first 10 rows and the “name” and “name2” columns.
# What is the difference between these two columns?
dataEns$name[1:10]
dataEns$name2[1:10]

# OPTIONAL: Database and tables structure is not the same between different assemblies
# The Ensembl data in hg38 is not in the ensGene table.
# Can you find in which table? Hint: look at the UCSC Genome Browser track.
# Get the same data for hg38 as the previous exercise did for hg19.
dbUCSClive <- dbConnect(MySQL(), 
                        user = 'genomep',
                        password = 'password',
                        dbname = 'hg38', 
                        host = 'genome-euro-mysql.soe.ucsc.edu',
                        port = 3306)
dbUCSClive_tables <- dbListTables(dbUCSClive)
grep("knownGene",dbUCSClive_tables, perl=TRUE, value=TRUE)
rsUCSClive = dbSendQuery(dbUCSClive, "SELECT * FROM knownGene")
dataEnshg38 <- fetch(rsUCSClive, n=Inf)
