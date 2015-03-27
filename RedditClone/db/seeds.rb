u1 = User.create!(username: "Austin_powers", password: "shagnow")
u2 = User.create!(username: "Nick", password: "password")

s1 = u1.moderated_subs.create!(title: "Cats", description: "cats!!!")
s2 = u2.moderated_subs.create!(title: "Not Cats", description: "anything but cats")
s3 = u1.moderated_subs.create!(title: "Cats 2", description: "two cats")

p1 = u1.posts.create!(title:"my cat", subs: [s1, s2])
