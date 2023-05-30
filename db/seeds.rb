# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ classification: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
#You will need to create a youser manually. Login to the application via Shibboleth then:

youser = User.create!(email: "rsmoke@umich.edu", created_at: "2023-05-01 16:40:21.026838000 -0400", updated_at: "2023-05-01 16:40:21.030985000 -0400", provider: nil, uid: "rsmoke", uniqname: "rsmoke", principal_name: "rsmoke@umich.edu", display_name: "Rick Smoke", person_affiliation: "staff", password: "secretsecret")

departments = Department.create!([
  {deptID: 999999, fullname: "LSA College", shortname: "LSA", updated_by: youser.id},
  {deptID: 171210, fullname: "Facilities", shortname: "FCL", updated_by: youser.id},
  {deptID: 170000, fullname: "Dean's Office", shortname: "DEANS", updated_by: youser.id}
])

roles = Role.create!([
  {title: "SuperUser", description: "Manager of all things", updated_by: youser.id},
  {title: "Department Administrator", description: "Can see, edit and delete all records that they have entered as well as any records that are associated to your department.", updated_by: youser.id},
  {title: "Recorder", description: "Can see, edit and delete only the items they have entered.", updated_by: youser.id}
])

permissions = Permission.create!([
  {role_id: roles.first.id, department_id: departments.first.id, updated_by: youser.id},
  {role_id: roles.second.id, department_id: departments.second.id, updated_by: youser.id},
  {role_id: roles.third.id, department_id: departments.second.id, updated_by: youser.id}
])

accesss = Access.create!([
  {permission_id: permissions.first.id, uniqname: youser.uniqname, updated_by: youser.id}
])

appraisal_types = AppraisalType.create!([
  {classification: "Payment Receipt", description: "A receipt from the purchase of the item that includes the clear description of the object, date of purchase, the price paid", updated_by: youser.id},
  {classification: "Comparable Value (like or comparble item)", description: "A document that details another item that is an obvious comparison", updated_by: youser.id},
  {classification: "External Appraisal - outside vendor", description: "A documented appraisal from an accredited appraisal service.", updated_by: youser.id},
  {classification: "Other", description: "An alternate means of receiving a god market value.", updated_by: youser.id}
])

page_info = PageInformation.create!([
  {location: "home", content: "This is information on how to use the application"},
  {location: "catalog", content: "This is information on how to use the catalog"},
  {location: "accesses", content: "This is information on how to use the accesses"}
])