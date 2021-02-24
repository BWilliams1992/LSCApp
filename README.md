# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* # Ruby version
    * Version 2.6.6

* # System dependencies
 * Yarn

 * Git

 * Terminal program

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# Description
* This app automatically generates invoices from jobs that can be created. This version is specifically for a cleaning business. The app is used to manage different building sites and the cleans and invoices associated with them 
* The price of each clean is set per site, per house and per clean type. 

# Installation 
* Clone the repository to your local machine
* Navigate to the repository in your prefered terminal application
* Run bundle install to install the gems required
* Run yarn install to install packages required

# Using the application locally
* Navigate to the repositorys location in the terminal and run rails s to start the server
* Open your browser and navigate to https://localhost:3000 
* Create an user account with and email or sign in via google. 
    * Please not to use the google calendar features of this application you must sign in using your google account 
* First create a location to use. Creating the location also creates the required number of plots for that location along with creating invoices from the specified start date to the current date
* Create houses to be used with the application, houses can be used across multiple locations
* Navigate to the locations page and add Houses to the site for use. Then set the cost of each clean per house on the site. You also have to set the cost per hour for variation orders. 
* Add a house to each plot
* The application is now ready for use. Add cleans to the application and it will automatically add an event to your primary calendar on google calendar along with logging it in the application itself. It will also add itself to the appropriate invoice for the location. 
* Extras can be added to a plot which will be automatically added to the invoices.