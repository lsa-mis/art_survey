# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

home_page = Annotation.create!(
  uri: 'static_pages/home', 
  updated_by: 'John Smith'
)

about_page = Annotation.create!(
  uri: 'static_pages/about', 
  updated_by: 'John Smith'
)

AppraisalType.create!([
  {
    name: 'Other',
    description: 'add notes in the assets appraisal description'
  },
  {
    name: 'Payment Receipt',
    description: 'Store receipt showing detailed transaction'
  },
  {
  name: 'Comparable Value',
  description: 'like or comaparble item'
  },
  {
    name: 'External Appraisal',
    description: 'Outside vendor'
  },
])

Department.create!([
  {
    name: "American Culture",  
    dept_number: 193000, 
    updated_by: "Joe User"
  },
  {
    name: "Anthro-History",  
    dept_number: 179200, 
    updated_by: "Joe User"
  },
  {
    name: "Anthropology",  
    dept_number: 172000, 
    updated_by: "Joe User"
  },
  {
    name: "Applied Physics",  
    dept_number: 184600, 
    updated_by: "Joe User"
  },
  {
    name: "Asian Languages & Cultures",  
    dept_number: 176000, 
    updated_by: "Joe User"
  },
  {
    name: "Astronomy",  
    dept_number: 172500, 
    updated_by: "Joe User"
  },
  {
    name: "Biological Station",  
    dept_number: 172700, 
    updated_by: "Joe User"
  },
  {
    name: "Biological Station: Osborn",  
    dept_number: 206610, 
    updated_by: "Joe User"
  },
  {
    name: "Biology - Undergraduate",  
    dept_number: 188900, 
    updated_by: "Joe User"
  },
  {
    name: "Biophysics",  
    dept_number: 554000, 
    updated_by: "Joe User"
  },
  {
    name: "Botanical Gardens",  
    dept_number: 206000, 
    updated_by: "Joe User"
  },
  {
    name: "CAAS: S. African Init.",  
    dept_number: 550100, 
    updated_by: "Joe User"
  },
  {
    name: "CaMLA: AEE",  
    dept_number: 181770, 
    updated_by: "Joe User"
  },
  {
    name: "CaMLA: Consulting",  
    dept_number: 181780, 
    updated_by: "Joe User"
  },
  {
    name: "CaMLA: ECCE (B2)",  
    dept_number: 181740, 
    updated_by: "Joe User"
  },
  {
    name: "CaMLA: ECPE (C2)",  
    dept_number: 181750, 
    updated_by: "Joe User"
  },
  {
    name: "CaMLA: General Admin",  
    dept_number: 181700, 
    updated_by: "Joe User"
  },
  {
    name: "CaMLA: GSI-OET",  
    dept_number: 181760, 
    updated_by: "Joe User"
  },
  {
    name: "CaMLA: MELAB",  
    dept_number: 181710, 
    updated_by: "Joe User"
  },
  {
    name: "CaMLA: MET",  
    dept_number: 181720, 
    updated_by: "Joe User"
  },
  {
    name: "CAMLA: Practice Materials",  
    dept_number: 181790, 
    updated_by: "Joe User"
  },
  {
    name: "CaMLA: Test Publications",  
    dept_number: 181730, 
    updated_by: "Joe User"
  },
  {
    name: "CAMLA: Young Learners",  
    dept_number: 181800, 
    updated_by: "Joe User"
  },
  {
    name: "Chemistry",  
    dept_number: 173500, 
    updated_by: "Joe User"
  },
  {
    name: "Classical Art/Archaeology",  
    dept_number: 173700, 
    updated_by: "Joe User"
  },
  {
    name: "Classical Studies",  
    dept_number: 174000, 
    updated_by: "Joe User"
  },
  {
    name: "Cognitive Neuroscience Program",  
    dept_number: 550500, 
    updated_by: "Joe User"
  },
  {
    name: "Cognitive Sci&Mach Intel",  
    dept_number: 174800, 
    updated_by: "Joe User"
  },
  {
    name: "College of Lit, Science & Arts",  
    dept_number: 170000, 
    updated_by: "Joe User"
  },
  {
    name: "Communication Studies",  
    dept_number: 188300, 
    updated_by: "Joe User"
  },
  {
    name: "Comparative Literature",  
    dept_number: 191400, 
    updated_by: "Joe User"
  },
  {
    name: "Complex Systems",  
    dept_number: 550400, 
    updated_by: "Joe User"
  },
  {
    name: "Computer Science",  
    dept_number: 174600, 
    updated_by: "Joe User"
  },
  {
    name: "Culture and Cognition Program",  
    dept_number: 550300, 
    updated_by: "Joe User"
  },
  {
    name: "DAAS",  
    dept_number: 190300, 
    updated_by: "Joe User"
  },
  {
    name: "Dean: Academic Affairs",  
    dept_number: 170300, 
    updated_by: "Joe User"
  },
  {
    name: "Dean: Auxiliary Services",  
    dept_number: 170700, 
    updated_by: "Joe User"
  },
  {
    name: "Dean: Classrooms",  
    dept_number: 171000, 
    updated_by: "Joe User"
  },
  {
    name: "Dean: Deans Office",  
    dept_number: 174200, 
    updated_by: "Joe User"
  },
  {
    name: "Dean: Development",  
    dept_number: 170200, 
    updated_by: "Joe User"
  },
  {
    name: "Dean: East Hall Tech Svcs",  
    dept_number: 185600, 
    updated_by: "Joe User"
  },
  {
    name: "Dean: Facilities",  
    dept_number: 170110, 
    updated_by: "Joe User"
  },
  {
    name: "Dean: Facilities",  
    dept_number: 171250, 
    updated_by: "Joe User"
  },
  {
    name: "Dean: Facilities Projects",  
    dept_number: 170100, 
    updated_by: "Joe User"
  },
  {
    name: "Dean: Finance",  
    dept_number: 170500, 
    updated_by: "Joe User"
  },
  {
    name: "Dean: Human Resources",  
    dept_number: 173800, 
    updated_by: "Joe User"
  },
  {
    name: "Dean: Info. Technology",  
    dept_number: 172900, 
    updated_by: "Joe User"
  },
  {
    name: "Dean: Instruc Support Svcs",  
    dept_number: 171200, 
    updated_by: "Joe User"
  },
  {
    name: "Dean: Interdept Activity",  
    dept_number: 179900, 
    updated_by: "Joe User"
  },
  {
    name: "Dean: Invested Department",  
    dept_number: 173600, 
    updated_by: "Joe User"
  },
  {
    name: "Dean: Machine Shop",  
    dept_number: 170150, 
    updated_by: "Joe User"
  },
  {
    name: "Dean: Mgmt. Info. Systems",  
    dept_number: 173900, 
    updated_by: "Joe User"
  },
  {
    name: "Dean: Outreach Staffing",  
    dept_number: 174100, 
    updated_by: "Joe User"
  },
  {
    name: "Dean: Planning/Operations",  
    dept_number: 174400, 
    updated_by: "Joe User"
  },
  {
    name: "Dean: Research/Grad. Stud.",  
    dept_number: 174300, 
    updated_by: "Joe User"
  },
  {
    name: "Dean: Shared Services",  
    dept_number: 174250, 
    updated_by: "Joe User"
  },
  {
    name: "Dean: Shared Svc-Dennison",  
    dept_number: 174253, 
    updated_by: "Joe User"
  },
  {
    name: "Dean: Shared Svc-MLB-Thayr",  
    dept_number: 174251, 
    updated_by: "Joe User"
  },
  {
    name: "Dean: Shared Svc-West Hall",  
    dept_number: 174252, 
    updated_by: "Joe User"
  },
  {
    name: "Dean: ShSvc-South State St",  
    dept_number: 174255, 
    updated_by: "Joe User"
  },
  {
    name: "Dean: Software Recharge",  
    dept_number: 172950, 
    updated_by: "Joe User"
  },
  {
    name: "Dean: TA Training",  
    dept_number: 171600, 
    updated_by: "Joe User"
  },
  {
    name: "Dean: Undergrad. Education",  
    dept_number: 171300, 
    updated_by: "Joe User"
  },
  {
    name: "Earth & Env Sci: CampDavis",  
    dept_number: 177075, 
    updated_by: "Joe User"
  },
  {
    name: "Earth & Env Sci: CC",  
    dept_number: 177050, 
    updated_by: "Joe User"
  },
  {
    name: "Earth & Env Sci: EMAL",  
    dept_number: 177100, 
    updated_by: "Joe User"
  },
  {
    name: "Earth & Environmental Sci.",  
    dept_number: 177000, 
    updated_by: "Joe User"
  },
  {
    name: "Ecology & Evolutionary Bio",  
    dept_number: 189100, 
    updated_by: "Joe User"
  },
  {
    name: "Economics",  
    dept_number: 175000, 
    updated_by: "Joe User"
  },
  {
    name: "ELI Testing and Cert Div",  
    dept_number: 181501, 
    updated_by: "Joe User"
  },
  {
    name: "ELI Testing and Cert Div",  
    dept_number: 181600, 
    updated_by: "Joe User"
  },
  {
    name: "English Language & Lit.",  
    dept_number: 175500, 
    updated_by: "Joe User"
  },
  {
    name: "English Language Institute",  
    dept_number: 181500, 
    updated_by: "Joe User"
  },
  {
    name: "Germanic Languages & Lit.",  
    dept_number: 178000, 
    updated_by: "Joe User"
  },
  {
    name: "GIEU Program",  
    dept_number: 517250, 
    updated_by: "Joe User"
  },
  {
    name: "Greek & Roman History Pgm",  
    dept_number: 174010, 
    updated_by: "Joe User"
  },
  {
    name: "Herbarium",  
    dept_number: 201200, 
    updated_by: "Joe User"
  },
  {
    name: "History",  
    dept_number: 179000, 
    updated_by: "Joe User"
  },
  {
    name: "History of Art",  
    dept_number: 179500, 
    updated_by: "Joe User"
  },
  {
    name: "Humanities Departments",  
    dept_number: 173000, 
    updated_by: "Joe User"
  },
  {
    name: "Humanities Institute",  
    dept_number: 171100, 
    updated_by: "Joe User"
  },
  {
    name: "Humanities Collaboratory",  
    dept_number: 173100, 
    updated_by: "Joe User"
  },
  {
    name: "II: African Studies Center",  
    dept_number: 195400, 
    updated_by: "Joe User"
  },
  {
    name: "II: Armenian Studies",  
    dept_number: 195200, 
    updated_by: "Joe User"
  },
  {
    name: "II: Atlantic Studies Init.",  
    dept_number: 191800, 
    updated_by: "Joe User"
  },
  {
    name: "II: Chinese Studies",  
    dept_number: 191000, 
    updated_by: "Joe User"
  },
  {
    name: "II: CSST",  
    dept_number: 195300, 
    updated_by: "Joe User"
  },
  {
    name: "II: European Studies",  
    dept_number: 195000, 
    updated_by: "Joe User"
  },
  {
    name: "II: Human Rights Initiatve",  
    dept_number: 194200, 
    updated_by: "Joe User"
  },
  {
    name: "II: Islamic Studies Prog",  
    dept_number: 192600, 
    updated_by: "Joe User"
  },
  {
    name: "II: Japanese Studies",  
    dept_number: 192000, 
    updated_by: "Joe User"
  },
  {
    name: "II: Latin Amer & Carib St",  
    dept_number: 195100, 
    updated_by: "Joe User"
  },
  {
    name: "II: ME & N. African St",  
    dept_number: 192500, 
    updated_by: "Joe User"
  },
  {
    name: "II: Nam Ctr Korean Studies",  
    dept_number: 194300, 
    updated_by: "Joe User"
  },
  {
    name: "II: Polish Studies",  
    dept_number: 194100, 
    updated_by: "Joe User"
  },
  {
    name: "II: Prg Intl Comp Studies",  
    dept_number: 193700, 
    updated_by: "Joe User"
  },
  {
    name: "II: Russ, EE & Eurasian St",  
    dept_number: 194000, 
    updated_by: "Joe User"
  },
  {
    name: "II: S. Asian Studies",  
    dept_number: 194400, 
    updated_by: "Joe User"
  },
  {
    name: "II: SE Asian Studies",  
    dept_number: 194500, 
    updated_by: "Joe User"
  },
  {
    name: "II: Weiser Emerging Democ",  
    dept_number: 195500, 
    updated_by: "Joe User"
  },
  {
    name: "II: Weiser Europe/Eurasia",  
    dept_number: 195600, 
    updated_by: "Joe User"
  },
  {
    name: "II: World Performance St",  
    dept_number: 193500, 
    updated_by: "Joe User"
  },
  {
    name: "International Institute",  
    dept_number: 190000, 
    updated_by: "Joe User"
  },
  {
    name: "Judaic Studies",  
    dept_number: 179100, 
    updated_by: "Joe User"
  },
  {
    name: "Kelsey Museum/Archaeology",  
    dept_number: 201500, 
    updated_by: "Joe User"
  },
  {
    name: "Linguistics",  
    dept_number: 181200, 
    updated_by: "Joe User"
  },
  {
    name: "LS&A Asia-American Studies",  
    dept_number: 193100, 
    updated_by: "Joe User"
  },
  {
    name: "LS&A Coll Inst/Values&Sciences",  
    dept_number: 170900, 
    updated_by: "Joe User"
  },
  {
    name: "LS&A Comm on Comp/Historic Res",  
    dept_number: 175100, 
    updated_by: "Joe User"
  },
  {
    name: "LS&A Ctr Great Lakes & Aquatic",  
    dept_number: 206600, 
    updated_by: "Joe User"
  },
  {
    name: "LS&A Environment Learning Comm",  
    dept_number: 173350, 
    updated_by: "Joe User"
  },
  {
    name: "LS&A Inteflex",  
    dept_number: 171800, 
    updated_by: "Joe User"
  },
  {
    name: "LS&A Latino Studies",  
    dept_number: 193200, 
    updated_by: "Joe User"
  },
  {
    name: "LS&A Mathematical Reviews",  
    dept_number: 206500, 
    updated_by: "Joe User"
  },
  {
    name: "LS&A Observatories",  
    dept_number: 172600, 
    updated_by: "Joe User"
  },
  {
    name: "LS&A Pgm in Amer. Institutions",  
    dept_number: 170600, 
    updated_by: "Joe User"
  },
  {
    name: "LS&A Research Sem Quan Eco",
    dept_number: 175200, 
    updated_by: "Joe User"
  },
  {
    name: "LSA- ITC Fund Stdnt Tech Fees",  
    dept_number: 171350, 
    updated_by: "Joe User"
  },
  {
    name: "Marketing & Communications",  
    dept_number: 174500, 
    updated_by: "Joe User"
  },
  {
    name: "Mathematics",  
    dept_number: 183000, 
    updated_by: "Joe User"
  },
  {
    name: "Molec./Cell./Develop. Bio",  
    dept_number: 189000, 
    updated_by: "Joe User"
  },
  {
    name: "Museum of Anthro Arch",  
    dept_number: 200500, 
    updated_by: "Joe User"
  },
  {
    name: "Museums",  
    dept_number: 200000, 
    updated_by: "Joe User"
  },
  {
    name: "Natural Science Department",  
    dept_number: 172200, 
    updated_by: "Joe User"
  },
  {
    name: "Near Eastern Studies",  
    dept_number: 183500, 
    updated_by: "Joe User"
  },
  {
    name: "Organizational Studies",  
    dept_number: 174700, 
    updated_by: "Joe User"
  },
  {
    name: "OS: Barger Leadership Inst",  
    dept_number: 174705, 
    updated_by: "Joe User"
  },
  {
    name: "Paleontology Museum",  
    dept_number: 202000, 
    updated_by: "Joe User"
  },
  {
    name: "Philosophy",  
    dept_number: 184000, 
    updated_by: "Joe User"
  },
  {
    name: "Physics",  
    dept_number: 184500, 
    updated_by: "Joe User"
  },
  {
    name: "Physics: Atomic/Molec./Opt",  
    dept_number: 184550, 
    updated_by: "Joe User"
  },
  {
    name: "Physics: Condensed Matter",  
    dept_number: 184540, 
    updated_by: "Joe User"
  },
  {
    name: "Physics: Focus Center",  
    dept_number: 184560, 
    updated_by: "Joe User"
  },
  {
    name: "Physics: High Energy Exper",  
    dept_number: 184510, 
    updated_by: "Joe User"
  },
  {
    name: "Physics: High Energy SPIN",  
    dept_number: 184530, 
    updated_by: "Joe User"
  },
  {
    name: "Physics: High Energy Theor",  
    dept_number: 184520, 
    updated_by: "Joe User"
  },
  {
    name: "Political Science",  
    dept_number: 185000, 
    updated_by: "Joe User"
  },
  {
    name: "Political Science: MIW",  
    dept_number: 185100, 
    updated_by: "Joe User"
  },
  {
    name: "Program in Neuroscience",  
    dept_number: 189050, 
    updated_by: "Joe User"
  },
  {
    name: "Programs & Centers",  
    dept_number: 172300, 
    updated_by: "Joe User"
  },
  {
    name: "Psychology",  
    dept_number: 185500, 
    updated_by: "Joe User"
  },
  {
    name: "Psychology: CSBYC",  
    dept_number: 185510, 
    updated_by: "Joe User"
  },
  {
    name: "Religious Studies",  
    dept_number: 194700, 
    updated_by: "Joe User"
  },
  {
    name: "Romance Languages & Lit.",  
    dept_number: 186500, 
    updated_by: "Joe User"
  },
  {
    name: "Science, Tech and Society",  
    dept_number: 191700, 
    updated_by: "Joe User"
  },
  {
    name: "Screen Arts & Cultures",  
    dept_number: 191600, 
    updated_by: "Joe User"
  },
  {
    name: "Slavic Languages & Lit.",  
    dept_number: 187000, 
    updated_by: "Joe User"
  },
  {
    name: "Social Science Departments",  
    dept_number: 172400, 
    updated_by: "Joe User"
  },
  {
    name: "Sociology",  
    dept_number: 187500, 
    updated_by: "Joe User"
  },
  {
    name: "Statistics",  
    dept_number: 188500, 
    updated_by: "Joe User"
  },
  {
    name: "Summer Language Inst.",  
    dept_number: 191300, 
    updated_by: "Joe User"
  },
  {
    name: "Sweetland Writing Center",  
    dept_number: 175600, 
    updated_by: "Joe User"
  },
  {
    name: "UG: CGIS",  
    dept_number: 171500, 
    updated_by: "Joe User"
  },
  {
    name: "UG: Comprehensive Studies",  
    dept_number: 191200, 
    updated_by: "Joe User"
  },
  {
    name: "UG: Curriculum Support",  
    dept_number: 171900, 
    updated_by: "Joe User"
  },
  {
    name: "UG: Environment",  
    dept_number: 173300, 
    updated_by: "Joe User"
  },
  {
    name: "UG: Global Scholars Prog",  
    dept_number: 191270, 
    updated_by: "Joe User"
  },
  {
    name: "UG: Hlth. Science Scholars",  
    dept_number: 174900, 
    updated_by: "Joe User"
  },
  {
    name: "UG: Honors",  
    dept_number: 180000, 
    updated_by: "Joe User"
  },
  {
    name: "UG: IDEA Institute",  
    dept_number: 171390, 
    updated_by: "Joe User"
  },
  {
    name: "UG: InterGroup Relations",  
    dept_number: 191250, 
    updated_by: "Joe User"
  },
  {
    name: "UG: Language Resource Ctr.",  
    dept_number: 182000, 
    updated_by: "Joe User"
  },
  {
    name: "UG: Lloyd Hall Scholars",  
    dept_number: 170400, 
    updated_by: "Joe User"
  },
  {
    name: "UG: M-SCI Program",  
    dept_number: 172801, 
    updated_by: "Joe User"
  },
  {
    name: "UG: Mich Community Schlrs",  
    dept_number: 171700, 
    updated_by: "Joe User"
  },
  {
    name: "UG: Mich Research Comm",  
    dept_number: 171401, 
    updated_by: "Joe User"
  },
  {
    name: "UG: Museum of Nat History",  
    dept_number: 201000, 
    updated_by: "Joe User"
  },
  {
    name: "UG: Museum Studies Minor",  
    dept_number: 170850, 
    updated_by: "Joe User"
  },
  {
    name: "UG: Residential College",  
    dept_number: 186000, 
    updated_by: "Joe User"
  },
  {
    name: "UG: Science Learning Ctr.",  
    dept_number: 172800, 
    updated_by: "Joe User"
  },
  {
    name: "UG: Student Acad. Affairs",  
    dept_number: 170800, 
    updated_by: "Joe User"
  },
  {
    name: "UG: Student Recruitment",  
    dept_number: 173200, 
    updated_by: "Joe User"
  },
  {
    name: "UG: University Courses",  
    dept_number: 172100, 
    updated_by: "Joe User"
  },
  {
    name: "UG: UROP",  
    dept_number: 171400, 
    updated_by: "Joe User"
  },
  {
    name: "Undergraduate Education",  
    dept_number: 171301, 
    updated_by: "Joe User"
  },
  {
    name: "Weinberg Inst for Cog Science",  
    dept_number: 181250, 
    updated_by: "Joe User"
  },
  {
    name: "Womens and Gender Studies",  
    dept_number: 188700, 
    updated_by: "Joe User"
  },
  {
    name: "Zoology Museum",  
    dept_number: 202500, 
    updated_by: "Joe User"
  },
  {
    name: "Zoology Museum: ES George",  
    dept_number: 202600, 
    updated_by: "Joe User"
  },
])

firstuser = User.create!(
    email: "moe@umich.edu",
    password: 'secret',
    password_confirmation: 'secret',
    lastname: "Stooge",
    firstname: "Moe",
    uniqname: "stoogemo"
  )

seconduser = User.create!(
  email: "sample@umich.edu",
  password: 'secret',
  password_confirmation: 'secret',
  lastname: "Crails",
  firstname: "Jerry",
  uniqname: "crailjer"
  )


