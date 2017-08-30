SHELL:=/bin/bash -l
all: 02-makefiles.md 03-variables.md 06-variables.md 09-conclusion.md

02-makefiles.md: 02-makefile_part1 02-makefile_part2 02-makefile_part3 ../code/02-makefile/Makefile ../code/02-makefile-challenge/Makefile
	@cat 02-makefile_part1 <(echo "> > \`\`\`Makefile") <(cat ../code/02-makefile/Makefile | sed 's/^/> > /g') <(echo "> > \`\`\`") 02-makefile_part2 <(echo "> > > \`\`\`Makefile") <(cat ../code/02-makefile-challenge/Makefile | sed 's/^/> > > /g') <(echo "> > > \`\`\`") 02-makefile_part3 > 02-makefiles.md

03-variables.md: 03-variables_part1 03-variables_part2 03-variables_part3 ../code/03-variables/Makefile ../code/03-variables-challenge/Makefile
	@cat 03-variables_part1 <(echo "> > \`\`\`Makefile") <(cat ../code/03-variables/Makefile | sed 's/^/> > /g') <(echo "> > \`\`\`") 03-variables_part2 <(echo "> > > \`\`\`Makefile") <(cat ../code/03-variables-challenge/Makefile | sed 's/^/> > > /g') <(echo "> > > \`\`\`") 03-variables_part3 > 03-variables.md

06-variables.md: 06-variables_part1 06-variables_part2 06-variables_part3 06-variables_part4 ../code/06-variables-challenge/Makefile ../code/06-variables/Makefile ../code/06-variables/config.mk
	@cat 06-variables_part1 <(echo "> > > \`\`\`Makefile") <(cat ../code/06-variables-challenge/Makefile | sed 's/^/> > > /g') <(echo "> > > \`\`\`") 06-variables_part2 <(echo "> > \`\`\`Makefile") <(cat ../code/06-variables/Makefile | sed 's/^/> > /g') <(echo "> > \`\`\`") 06-variables_part3 <(echo "> > \`\`\`Makefile") <(cat ../code/06-variables/config.mk | sed 's/^/> > /g') <(echo "> > \`\`\`") 06-variables_part4 > 06-variables.md

09-conclusion.md: 09-conclusion_part1 09-conclusion_part2 09-conclusion_part3 09-conclusion_part4 09-conclusion_part5 ../code/09-conclusion-challenge-1/Makefile ../code/09-conclusion-challenge-1/config.mk ../code/09-conclusion-challenge-2/Makefile ../code/09-conclusion-challenge-2/config.mk
	@cat 09-conclusion_part1 <(echo "> > > \`\`\`Makefile") <(cat ../code/09-conclusion-challenge-1/Makefile | sed 's/^/> > > /g') <(echo "> > > \`\`\`") 09-conclusion_part2 <(echo "> > > \`\`\`Makefile") <(cat ../code/09-conclusion-challenge-1/config.mk | sed 's/^/> > > /g') <(echo "> > > \`\`\`") 09-conclusion_part3 <(echo "> > > \`\`\`Makefile") <(cat ../code/09-conclusion-challenge-2/Makefile | sed 's/^/> > > /g') <(echo "> > > \`\`\`") 09-conclusion_part4 <(echo "> > > \`\`\`Makefile") <(cat ../code/09-conclusion-challenge-2/config.mk | sed 's/^/> > > /g') <(echo "> > > \`\`\`") 09-conclusion_part5 > 09-conclusion.md

delete:
	@rm 02-makefiles.md 03-variables.md 06-variables.md 09-conclusion.md
