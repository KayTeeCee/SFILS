
Results README

For my findings, I saw the following:

Age Range	Patron Activity	Total Checkouts	Total Renewals
0 to 9 years	34,642	2,373,254	1,619,258
10 to 19 years	67,320	13,912,059	4,743,235
20 to 24 years	24,484	4,005,601	1,158,954
25 to 34 years	92,790	4,443,586	2,484,669
35 to 44 years	80,477	6,153,650	4,421,865
45 to 54 years	48,752	9,011,605	5,417,604
55 to 59 years	19,281	5,056,298	2,545,055
60 to 64 years	17,664	5,250,138	2,517,262
65 to 74 years	31,906	11,547,611	5,034,753
75 years and over	18,872	7,970,338	2,676,735

With these statistics, we can see that the San Francisco Library is very popular and is very active when looking at the total checkouts and renewals compared to the amount of patrons. We see that the most popular demographics are people in the age ranges of 25 to 34. Surprisingly, the highest amount of total checkouts does not occur in that same range, and instead belongs to the 10 to 19 age bracket with 13,912,059 checkouts, closely followed by the 65 to 74 years old range. The highest amount of total renewals goes to the age range of 45 to 54 years old.
For the performance, I saw the following runtimes:
text
create_tables script  - 0.020266 seconds
migration_script      - 29.923000 seconds
age range data query  - 0.450000 seconds
importing csv         - 1055.510000 seconds
Use code with caution.
While most of the runtimes were around the same across different runs, importing the CSV varied for unknown reasons. On earlier runs, I got times as early as 450 seconds, but for the last run, it took me 1055.51 seconds.
