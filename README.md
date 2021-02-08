# Welcome to Socialising

This is a simple location sharing application using Ruby on Rails.

## Application Description
- User can signup into this application by providing username, email, password and password confirmation.
- After successful signup user will receive one confirmation mail. Without confirmation of mail user can not login into application. If user didn't receive any confirmation mail then user can send this instruction to email by using *Didn't receive confirmation email? Click here* link.
- User can login into this application by providing email and password. In case user forgot the password, then user can recover password by using *Forgot password* link. Here use will receive one instruction mail and reset the password.
- User can unlock account by providing email. User can recover account by using *Didn't receive unlock email? Click here* link. Here user will receive one instruction mail.
- User can share a location by clicking *Share Location* button and give location name and selecting user with whom they want to share location.
- In *Timeline* page, we have all the locations(with map) which are shared by the logged in user and the locations shared with the logged in user.
- Also for each location, there is a link on the user name who shared the location, this link will carry you to a page where that specific user has shared their locations as public.
- User can see all users along with their status of accepting or receiving or pending friend request by clicking *All Users* link in the dropdown in navbar.
- User can see all the Friend Requests by clicking *Friend Request* link inside the navbar dropdown. There they can accept or reject the requests.
- User can also view all the *Accepted*, *Rejected*, *Pending* friend requests by clicking the respective links in *Friend Requests* page.
- User can reset account details clicking *Account Settings* link inside navbar dropdown.
- User can logout from application by clicking *Log Out* link at the navbar dropdown.

## Technical Stack
- Ruby v2.7.2
- Rails v6.1.0
- PostgreSQL 13.0

## Development Setup

- Set up Ruby on Rails on linux based OS. For installation please follow this link [Ruby and Rails Installation Guide](https://gorails.com/setup/ubuntu/18.04). Here please use **RVM** for the development.
- Clone this repository into your system. [Clone GitHub Repository Guide](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository)
- Open terminal and go to the project path.
- It will create one gemset for this project. Please install bundler first. For the installation of bundler please run this bellow command.
  > gem install bundler -v 2.1.4
- Install all gem by following bellow command.
  > bundle install
- Copy and paste database.yml.sample file inside config folder then rename this file to **database.yml**.
- Install PostgreSQL for database into this OS. Please follow this link [PostgreSQL Installation Guide](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-18-04).
- Start rails server with bellow command.
    > rails server
- Visit [http://localhost:3000](http://localhost:3000). You are on home page.

## Testing

Rspec is there for unit testing. After running test suite one test coverage will be generated inside the project folder. For this test coverage *SimpleCov* has been used.

![test coverage](https://github.com/JhumurChatterjee/socialising/blob/master/vendor/coverage.png?raw=true)
