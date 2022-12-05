# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ classification: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# AppraisalType.create(classification: "Payment Receipt", updated_by: 1)
# AppraisalType.create(classification: "Comparable Value (like or comaparble item)", updated_by: 1)
# AppraisalType.create(classification: "External Appraisal - outside vendor", updated_by: 1)
# AppraisalType.create(classification: "Other", updated_by: 1)

# Department.create!([
#   {fullname: 'American Culture', deptID: 193000, shortname: 'Am Cult', updated_by: 1},
#   {fullname: 'Anthro-History', deptID: 179200, shortname: 'Anthro-Hist', updated_by: 1},
#   {fullname: 'Anthropology', deptID: 172000, shortname: 'ANTH', updated_by: 1},
#   {fullname: 'Applied Physics', deptID: 184600, shortname: 'AppPhys', updated_by: 1},
#   {fullname: 'Asian Languages & Cultures', deptID: 176000, shortname: 'Asian', updated_by: 1}
# ])

PageInformation.create!(location: 'home')

Department.create!(
  [deptID: 171210, fullname: "Facilities", shortname: "FCL"],
  [deptID: 170000, fullname: "Dean's Office", shortname: "DEANS"]
)

Role.create!(
  [title: "SuperUser", description: "Manager of all things"],
  [title: "Department Administrator", description: "Can see, edit and delete all records that they have entered as well as any records that are associated to your department."],
  [title: "Recorder", description: "Can see, edit and delete only the items they have entered."]
)

Permission.create!(
  [role_id: Role.first, department_id: Department.first],
  [role_id: Role.second, department_id: Department.first],
  [role_id: Role.third, department_id: Department.first]
)

Access.create!(
  [permission_id: Permission.first, uniqname: "<your uniqname>"]
)
