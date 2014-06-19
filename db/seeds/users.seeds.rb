u = User.where(email: "y.yalda@inlink.com.au").first_or_create(first_name: "Yaniv", surname: "Yalda", password: "testing123")
u.add_role :administrator