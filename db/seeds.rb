/to/seeds/20150928000000_initial_see

r1 = Role.create({name: "Regular", description: "Can read items"})
r2 = Role.create({name: "Seller", description: "Can read and create items. Can update and destroy own items"})
r3 = Role.create({name: "Admin", description: "Can perform any CRUD operation on any resource"})

u1 = User.create({name: "Fernando", email: "fernando.torres.valencia@gmail.com", password: "esinvitado", password_confirmation: "esinvitado", role_id: r1.id}) 
u2 = User.create({name: "NorbertoGiraldo", email: "jonogigi01@yahoo.com", password: "norberto2015", password_confirmation: "norberto2015", role_id: r2.id})
u3 = User.create({name: "GerenteNanducho", email: "gerencia@nanducho.com", password: "nanducho2015", password_confirmation: "nanducho2015", role_id: r3.id})