namespace :departments do
  desc "Import department data from the provided list"
  task import: :environment do
    # Department import data
    departments_data = [
      { deptID: 170200, fullname: "Advancement", shortname: "ADV" },
      { deptID: 193000, fullname: "American Culture", shortname: "Am Cult" },
      { deptID: 179200, fullname: "Anthro-History", shortname: "Anthro-Hist" },
      { deptID: 172000, fullname: "Anthropology", shortname: "ANTH" },
      { deptID: 176000, fullname: "Asian Languages & Cultures", shortname: "Asian" },
      { deptID: 172500, fullname: "Astronomy", shortname: "ASTR" },
      { deptID: 174705, fullname: "Barger Leadership Institute", shortname: "BLI" },
      { deptID: 189999, fullname: "Biological Science Building", shortname: "BSB" },
      { deptID: 188900, fullname: "Biology", shortname: "BIO" },
      { deptID: 554000, fullname: "Biophysics", shortname: "BIOP" },
      { deptID: 172700, fullname: "Bio Station", shortname: "UMBS" },
      { deptID: 171500, fullname: "Center for Global & Intercultural Study", shortname: "CGIS" },
      { deptID: 187200, fullname: "Center for Social Solutions", shortname: "CSS" },
      { deptID: 550400, fullname: "Center for the Study of Complex Systems", shortname: "CSCS" },
      { deptID: 173500, fullname: "Chemistry", shortname: "CHEM" },
      { deptID: 173700, fullname: "Classical Art/Archaeology", shortname: "Art/Arch" },
      { deptID: 174000, fullname: "Classical Studies", shortname: "ClasStds" },
      { deptID: 188300, fullname: "Communication and Media", shortname: "COMM" },
      { deptID: 191400, fullname: "Comparative Literature", shortname: "Comp Lit" },
      { deptID: 191200, fullname: "Comprehensive Studies Program", shortname: "CSP" },
      { deptID: 190300, fullname: "DAAS", shortname: "DAAS" },
      { deptID: 171000, fullname: "Dean: Classrooms", shortname: "Classrooms" },
      { deptID: 174200, fullname: "Dean: Dean Office", shortname: "LSA Dean" },
      { deptID: 170500, fullname: "Dean: Finance", shortname: "Finance" },
      { deptID: 173800, fullname: "Dean: Human Resources", shortname: "HR" },
      { deptID: 171300, fullname: "Dean: Undergrad Education", shortname: "UgradED" },
      { deptID: 171302, fullname: "dHUB", shortname: "HUB" },
      { deptID: 193200, fullname: "Digital Studies Institute", shortname: "DSI" },
      { deptID: 177000, fullname: "Earth and Environmental Science", shortname: "EARTH" },
      { deptID: 177075, fullname: "Earth & Env Sci: CampDavis", shortname: "EES-CampDavis" },
      { deptID: 189100, fullname: "Ecology & Evolutionary Bio", shortname: "EEB" },
      { deptID: 175000, fullname: "Economics", shortname: "ECON" },
      { deptID: 175500, fullname: "English", shortname: "ENG" },
      { deptID: 170110, fullname: "Facilities", shortname: "FCL" },
      { deptID: 191600, fullname: "Film", shortname: "Television" },
      { deptID: 174257, fullname: "Finance: BSBO Fin", shortname: "BSBO" },
      { deptID: 174254, fullname: "Finance: CBBO Fin", shortname: "CBBO" },
      { deptID: 174256, fullname: "Finance: East Hall", shortname: "Fin EH" },
      { deptID: 170950, fullname: "Finance: Procurement", shortname: "Procurement" },
      { deptID: 174258, fullname: "Finance: Randall", shortname: "Fin Ran" },
      { deptID: 174252, fullname: "Finance: West Hall", shortname: "Fin WH" },
      { deptID: 178000, fullname: "Germanic Languages & Lit.", shortname: "German" },
      { deptID: 174010, fullname: "Greek & Roman History Pgm", shortname: "Greek&Roman" },
      { deptID: 201200, fullname: "Herbarium", shortname: "Herb" },
      { deptID: 179000, fullname: "History", shortname: "Hist" },
      { deptID: 179500, fullname: "History of Art", shortname: "HART" },
      { deptID: 180000, fullname: "Honors", shortname: "HONORS" },
      { deptID: 171100, fullname: "Humanities Institute", shortname: "Hum Inst" },
      { deptID: 174251, fullname: "Humanities Units", shortname: "HUM" },
      { deptID: 195400, fullname: "II: African Studies Center", shortname: "II-ASC" },
      { deptID: 195200, fullname: "II: Armenian Studies", shortname: "II-ASP" },
      { deptID: 194200, fullname: "II: Human Rights Initiative", shortname: "II-DHRC" },
      { deptID: 192600, fullname: "II: Islamic Studies Prog", shortname: "II-GISC" },
      { deptID: 192000, fullname: "II: Japanese Studies", shortname: "II-CJS" },
      { deptID: 195100, fullname: "II: Latin Amer & Carib St", shortname: "II-LACS" },
      { deptID: 192500, fullname: "II: ME & N. African St", shortname: "II-CMENAS" },
      { deptID: 194300, fullname: "II: Nam Ctr Korean Studies", shortname: "II-NCKS" },
      { deptID: 194100, fullname: "II: Polish Studies", shortname: "II-CPPS" },
      { deptID: 193700, fullname: "II: Prg Intl Comp Studies", shortname: "II-PICS" },
      { deptID: 194000, fullname: "II: Russ", shortname: "EE & Eurasian St" },
      { deptID: 194400, fullname: "II: S. Asian Studies", shortname: "II-CSAS" },
      { deptID: 194500, fullname: "II: SE Asian Studies", shortname: "II-CSEAS" },
      { deptID: 195000, fullname: "II: SE Asian Studies", shortname: "II-CES" },
      { deptID: 195600, fullname: "II: Weiser Emerging Democr", shortname: "II-WCED" },
      { deptID: 195500, fullname: "II: Weiser Europe/Eurasia", shortname: "II-WCEE" },
      { deptID: 193500, fullname: "II: World Performance St", shortname: "II-WPS" },
      { deptID: 190000, fullname: "International Institute", shortname: "II" },
      { deptID: 179100, fullname: "Judaic Studies", shortname: "JUDAIC" },
      { deptID: 201500, fullname: "Kelsey Museum of Archeology", shortname: "KELSEY" },
      { deptID: 181200, fullname: "Linguistics", shortname: "LING" },
      { deptID: 181250, fullname: "Linguistics: Weinberg ICS", shortname: "Weinberg" },
      { deptID: 170100, fullname: "LSA Dean: Facilities Projects", shortname: "Facilities" },
      { deptID: 191000, fullname: "LSA II: Chinese Studies", shortname: "II-LRCCS" },
      { deptID: 172800, fullname: "LSA UG Science Learning Center", shortname: "Science Learning Center (SLC)" },
      { deptID: 183000, fullname: "Mathematics", shortname: "MATH" },
      { deptID: 497000, fullname: "Michigan Quarterly Review", shortname: "MQR" },
      { deptID: 183500, fullname: "Middle East Studies", shortname: "MES" },
      { deptID: 173100, fullname: "MI Humanities Collab.", shortname: "MI Hum Collab" },
      { deptID: 186510, fullname: "MLB Thayer Events & Comm", shortname: "Thayer" },
      { deptID: 189000, fullname: "Mol./Cell./Develop. Bio", shortname: "MCDB" },
      { deptID: 200500, fullname: "Museum of Anthropology", shortname: "MANTH" },
      { deptID: 202000, fullname: "Museum of Paleontology", shortname: "Mus Paleon" },
      { deptID: 517900, fullname: "Natl Ctr Inst Diversity", shortname: "NCID" },
      { deptID: 170160, fullname: "NMR Core", shortname: "NMR" },
      { deptID: 171303, fullname: "optiMize", shortname: "optiMize" },
      { deptID: 174700, fullname: "Organizational Studies", shortname: "OrgStds" },
      { deptID: 184000, fullname: "Philosophy", shortname: "PHIL" },
      { deptID: 184500, fullname: "Physics", shortname: "PHYS" },
      { deptID: 185000, fullname: "Political Science", shortname: "PoliSci" },
      { deptID: 185100, fullname: "Political Science: MIW", shortname: "MIW" },
      { deptID: 196000, fullname: "Program in Computing for Arts and Science", shortname: "PCAS" },
      { deptID: 189050, fullname: "Program in Neuroscience", shortname: "Neuro" },
      { deptID: 185500, fullname: "Psychology", shortname: "PSYCH" },
      { deptID: 185510, fullname: "Psychology: CSBYC", shortname: "CSBYC" },
      { deptID: 175300, fullname: "Quantitative Methods and Social Science Program", shortname: "QM&SS" },
      { deptID: 186000, fullname: "Residential College", shortname: "RC" },
      { deptID: 186500, fullname: "Romance Languages and Literatures", shortname: "RLL" },
      { deptID: 191700, fullname: "Science Tech and Society", shortname: "STS" },
      { deptID: 187000, fullname: "Slavic Languages & Lit.", shortname: "Slavic" },
      { deptID: 174255, fullname: "Social Science Units", shortname: "SocSci" },
      { deptID: 187500, fullname: "Sociology", shortname: "SOC" },
      { deptID: 188500, fullname: "Statistics", shortname: "STATS" },
      { deptID: 175600, fullname: "Sweetland Writing Center", shortname: "Sweetland" },
      { deptID: 172900, fullname: "Technology Services", shortname: "TS" },
      { deptID: 171200, fullname: "Technology Services Academic Technology", shortname: "TSAT" },
      { deptID: 181500, fullname: "UG: English Language Inst", shortname: "ELI" },
      { deptID: 182000, fullname: "UG: Language Resource Ctr.", shortname: "LRC" },
      { deptID: 170400, fullname: "UG: Lloyd Scholars- W&A", shortname: "Lloyd" },
      { deptID: 201000, fullname: "UG: Museum of Nat History", shortname: "Mus Nat Hist" },
      { deptID: 170800, fullname: "UG: Student Acad. Affairs", shortname: "Acad Affairs" },
      { deptID: 191300, fullname: "UG: Summer Language Inst", shortname: "UG Summer Lang" },
      { deptID: 171400, fullname: "Undergraduate Research Opportunity Program", shortname: "UROP" },
      { deptID: 188700, fullname: "Women's and Gender Studies", shortname: "WomStds" }
    ]

    puts "Starting department import..."

    # Track statistics
    created_count = 0
    skipped_count = 0
    error_count = 0

    departments_data.each do |dept_data|
      begin
        # Add updated_by field
        dept_data[:updated_by] = 1

        # Check if department already exists
        existing_dept = Department.find_by(deptID: dept_data[:deptID])

        if existing_dept
          puts "Skipping #{dept_data[:fullname]} (deptID: #{dept_data[:deptID]}) - already exists"
          skipped_count += 1
        else
          department = Department.create!(dept_data)
          puts "Created: #{department.fullname} (deptID: #{department.deptID})"
          created_count += 1
        end
      rescue => e
        puts "Error creating #{dept_data[:fullname]}: #{e.message}"
        error_count += 1
      end
    end

    puts "\nImport completed!"
    puts "Created: #{created_count} departments"
    puts "Skipped: #{skipped_count} departments (already exist)"
    puts "Errors: #{error_count} departments"
  end
end
