# Baseball

## Getting the project ready
The project uses Ruby 2.1.2 as specified by the `.ruby-version` file. 
You'll want to install this version on your system.
The project also make us of Bundler for it's gem management.

Run `bundle install` from the root directoy to install all needed gems.

## Running the Application
Simple call the baseball.rb file from the command line: `bin/baseball.rb`

## Architecture

The application borrows from principles from Domain Driven Design and CQRS.

### Project Layout

**Application.rb**: Runs the application but delegates to the Domain namespace for all business logic.

**data**: Contains the data source, the CSV files.

**domain**: The heart of all the domain logic. This is where most of the functionality lives.

**domain/entities**: These objects that represent certain nouns or abstractions of the domain. 
  Similar to models from Rails but without the functionality seen in Rails models.

**domain/repositories**: Is responsible for mapping the data to entities.

**domain/queries**: Responsible for returning any actionable data the domain needs. 
  Quieries cannot modify state and are part of the CQRS architecture.

**domain/commands**: Actions that will modify state or make a change. No data will be returned from the commands.
This an implementation of the command pattern and also follows CQRS.


### Dependency Injection

Dependency Injection done through property injection has been utilized throughout the application.

If an object is not given a dependency by an outside source, then it will use a default dependency.
This allow an object to be functional independently without coupling it to an externality such as
a dependency injection framework. A similar alternative to this approach would be to have default dependency
be a null object (null object pattern). In that case the object can still be functional, but calls to the
default dependencies would do nothing.

## Automated Testing

MiniTest is used at the testing framework. Unit testing has be done on all the classes in the domain folder.

## Possible Improvements

As with all applications, there can be more possible improvements:

- Improve the speed of  slugging percentages query which is currently quite slow. 
- If the application become complex, it may be worth abstracting STDOUT away from the domain commands 
  and instead have an output object injected. 
- While the application has sufficient unit test coverage, an overall automated system test would be nice too.
  