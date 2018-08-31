# FileUpload

Here you will find everything you need to know about running the graphical user interface

## Installing

There are certain things you need to make sure you have set up at server-side:

* [R](https://cran.r-project.org/) VERSION 3.5.1 (MXNET will only work for 3.5.1 and above)
* [npm](https://nodejs.org/en/) 
* set environment variable to R.exe *(.../R/R-3.5.1/bin/x64)*, otherwise you will get **command not found**
* make sure the following packages are in R's main library path *(.../R/R-3.5.1/library)*  you can just copy&paste packages folders and every other package they need
    * MXNet
    * Imager
    * Here
* run the following commands inside file-upload/ folder
	>npm install -g nodemon
	
	>npm install --save-dev @angular-devkit/build-angular

To verify that the connection from Node.js and R model, create a basic script that loads `here` package and run that script via terminal `Rscript script_name.R`. If eveything goes well, you should receive the package startup message from `here` package. Assuming all required packages are in the correct library folder, everything is ready.

The two npm commands should have everything ready to run the application.

## Running the application

Open command line in file-upload/ and run `npm run build`. Navigate to `http://localhost:3000/`.

### Troubleshooting

Here are the commands we have used to set up the application. If something goes wrong, i.e. modules not present, you can try to install them manually.

    cd "app-name"

    npm install express

    npm install -g nodemon

    npm install bootstrap

        "node_modules/bootstrap/dist/css/bootstrap.min.css" in angular.json["styles"]

	npm install --save @ng-bootstrap/ng-bootstrap

		app.module.ts:
			import {NgbModule} from '@ng-bootstrap/ng-bootstrap';
			
			@NgModule({
 				...
  				imports: [...,NgbModule.forRoot(), ...],
  				...
			})

		other/other.component.ts:
			import {NgbModule} from '@ng-bootstrap/ng-bootstrap';
			@NgModule({
 				...
  				imports: [...,NgbModule, ...],
  				...
			})
	
	npm install --save multer

	create file: server.js

	package.json:
		"build": "ng build && nodemon server.js"

    npm run build

# Auto Generated Readme

This project was generated with [Angular CLI](https://github.com/angular/angular-cli) version 6.0.8.

## Development server

Run `ng serve` for a dev server. Navigate to `http://localhost:4200/`. The app will automatically reload if you change any of the source files.

## Code scaffolding

Run `ng generate component component-name` to generate a new component. You can also use `ng generate directive|pipe|service|class|guard|interface|enum|module`.

## Build

Run `ng build` to build the project. The build artifacts will be stored in the `dist/` directory. Use the `--prod` flag for a production build.

## Running unit tests

Run `ng test` to execute the unit tests via [Karma](https://karma-runner.github.io).

## Running end-to-end tests

Run `ng e2e` to execute the end-to-end tests via [Protractor](http://www.protractortest.org/).

## Further help

To get more help on the Angular CLI use `ng help` or go check out the [Angular CLI README](https://github.com/angular/angular-cli/blob/master/README.md).
