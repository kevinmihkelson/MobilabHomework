# Test Assignment for iOS developer role

## The goal of the application.

The goal of the application is to make everyday shopping easier by enabling the user to list down items to buy. While shopping, the application should also help track items that are already collected and make sure the user does not forget anything.

## How to compile and run the application
This application is written in Swift and requires the Swift Package Manager. To compile and run the application, you will need to:

1. Install the Swift Package Manager.
2. Clone the repository to your local machine.
3. Open the project in Xcode.
4. Run the following command in the project directory:
swift package update

This will install the dependencies and update the project's Xcode project file.

5. Click on the Play button in Xcode to run the application.

The application should now be running.

## How to run tests for the application
This application uses the XCTest framework to run unit tests. To run the tests, you will need to do the following:

1. Open the project in Xcode.
2. Click on the "Test" navigator.
3. Select the tests that you want to run.
4. Click on the "Play" button in the toolbar.

The tests will now be run.

## App architecture

I used the Model-View-ViewModel (MVVM) pattern for this project.

This application is structured as follows:

* **The presentation layer**
    * The views are responsible for displaying the data and handling user input.
    * The view models are responsible for providing the views with the data that they need and handling user input.
* **The data layer**
    * The Service class is responsible for fetching data from the REST API.
    * The RestAPIClient class is responsible for making HTTP requests to the REST API.
    * The APIRouter class is responsible for mapping URLs to methods in the restapiclient class.

All the data is stored in the cloud, using the Firebase Database REST API.

### Models 

The following models are used in the app:

* **TaskList**
    * id: A unique identifier for the task list
    * title: The title of the task list
    * tasks: A List of ==TaskParent== objects. Each == TaskParent == object represents a task in the task list.
    
* **Task**
    * id: A unique identifier for the task
    * content: The content of the task.
    * completed: A boolean value of that indicates whether the task is completed.
    
* **TaskParent**
    * name: The name of the parent task, which is provided by the Firebase Database RestAPI.
    * task: A == Task == object

* **FirebaseTaskList**
    * id: A unique identifier for the task list
    * title: The title of the task list.
    * tasks: A dictionary that maps task names to == Task == objects.
    
