# README

# Description/Features
* This app is a tool for management in a construction cleaning business. It allows for the easy logging of clean jobs and from these it automatically generates invoices for the business.
* Can be used to manage a google calendar linked to the users google account. Will create events corresoponding to the clean jobs created within the app. 

# Requirements
* Ruby version 2.6.6 or higher
* Bundle gem
* Yarn
* Git
* Terminal program
* Postgresql

# Quickstart
## Installation 
* Clone the repository to your local machine
* Navigate to the repository in your prefered terminal application
* Run bundle install to install the gems required
* Run yarn install to install packages required
* Run rails db:setup to create and migrate the database
* Get the google user secret and add to .env file to use google authentication 

## Using the application locally
#### Create user account
* Navigate to the repositorys location in the terminal and run rails s to start the server
* Open your browser and navigate to https://localhost:3000 
* Create an user account with and email or sign in via google. 
    * Please note to use the google calendar features of this application you must sign in using your google account
    #### Setting up google OAuth for use 
    * Open your browser and navigate to https://console.developers.google.com
    * Under APIs & Services click on credentails
    * You then need to create credentials for your application. Click on create credentials and choose OAuth client ID.
    * Set the application type to Web Application and enter a name for the application 
    * Create a URI for http://localhost:3000
    * Then enter the client id and client secret into the .env file for your application
    #### Setting up google calendar api for use
    * Return to the google dev console dashboard and click on enable apis
    * Search for and install the Google Calendar API
    #### Making a user admin
    * Open a separate terminal window and navigate to the repository. Run the command rails c to open up the rails console
    * With the rails console open you can change the admin status of a user account. Assuming your account is the first one to be created it can be accessed via User.first 
    * Assign this to a new object 'user = User.first' then the access the admin property via 'user.admin = true' to set the user as an admin
    * Then save the updated user object to the database 'user.save'
#### Using the application
* First create a location to use. Creating the location also creates the required number of plots for that location along with creating invoices from the specified start date to the current date
* Create houses to be used with the application, houses can be used across multiple locations
* Navigate to the locations page and add Houses to the site for use. Then set the cost of each clean per house on the site. You also have to set the cost per hour for variation orders. 
* Add a house to each plot
* The application is now ready for use. Add cleans to the application and it will automatically add an event to your primary calendar on google calendar along with logging it in the application itself. It will also add itself to the appropriate invoice for the location. 
* Extras can be added to a plot which will be automatically added to the invoices.

## Running the test suite
* This application uses rspec for automated testing, to run the tests run bundle exec rspec
* For documentation formatting run with --format documentation 