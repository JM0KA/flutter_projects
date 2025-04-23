# Bread Bank

## Purpose

The purpose of this project was originally to test my competencies in flutter and dart. As part of my mobile application final assignment I decided to build a personal budgeting app that would allow the user to set a budget and keep track of their personal expenses.  

Since I have completed the requirements for the assignment I have decided to continue working on this application to further develop my skills with flutter and dart.

## Learning Competencies

This project has helped develop my skills in state management and local data storage. The hope is that as I continue to work on this project, my understanding in both these fields will continue to grow.  

Currently, this application uses the `Provider` package to handle state management. Using `ChangeNotifier` to handle any changes that may occur while adding or deleting expenses. In terms of local storage I am also using the `SQflite`. I was also able to implement data visualizations using the `fl_chart` package.

So far, building this application has shown me the importance of writing clean and concise code. With a framework like flutter, it can become very confusing to figure out where to layer certain widgets or stylings. This has also caused problems when trying to find certain widgets and has resulted in me modularizing as much as possible in order to keep everything as clean/clear as possible.

## Project Structure

```
Lib/  
  |--> Managers/  
    - This folder is responsible for the initialization of the database. It also holds the functions responsible for persisting data to and from the widgets  
  |--> Models/  
        - This folder contains the `DbExpense` model repsonsible for mapping all the data to local storage.  
  |--> Pages/  
        - Responsible for holding all the screen/page widgets (excluding modals)  
  |--> Widgets/  
      - This folder is responsible for housing all my widgets, both reusable and single use widgets are held here  
  |--> Providers/  
        - Responsible for storing all ChangeNotifier-class functions  
        - This Provider will manage the app's core state, such as expense info, balance updates, and budget status  
  |--> Main.dart  
        - This is the main entry point of the app. It handles the initialization, routing and Proivder setup  
  |--> Routes.dart  
        - This houses the named paths for the pages routes  
Tests/  
    - This folder will contain all the user and widget tests that I create throughout the development of the application
```
