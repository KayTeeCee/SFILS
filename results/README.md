# Results README
For my findings, I saw the following:

Age Range              Patron Activity      Total Checkouts      Total Renewals
0 to 9 years           34642                2373254              1619258
10 to 19 years         67320                13912059             4743235
20 to 24 years         24484                4005601              1158954
25 to 34 years         92790                4443586              2484669
35 to 44 years         80477                6153650              4421865
45 to 54 years         48752                9011605              5417604
55 to 59 years         19281                5056298              2545055
60 to 64 years         17664                5250138              2517262
65 to 74 years         31906                11547611             5034753
75 years and over      18872                7970338              2676735

With these statistics, we can see that the San Francisco Library is very popular and is very active when looking at the total checkouts and renewals compared to the amount of patrons. We see that the most popular demographics are people in the age ranges of 25 to 34. Surprisingly, the most amounts of total checkouts are not in the same range, and instead are the age ranges 65 to 74 years old. The most amounts of total renewals goes to the age ranges 45 to 54 years old.


For the performance, I saw the following runtimes:

create_tables script - 0.020266 seconds
migration_script - 29.923 seconds
age range data query - 0.450 seconds
importing csv - 1055.51 seconds

While most of the runtimes were around the same across different runs, importing the CSV varied for unknown reasons. On earlier runs, I got times as early as 450 seconds, but for the last run, it took me 1055.51 seconds.
