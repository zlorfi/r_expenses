organization = Organization.create(name: 'Michi Crew')

User.create(username: 'Michi',
            email: 'me@me.com',
            password: 'me@me.com',
            password_confirmation: 'me@me.com',
            organization: organization)
