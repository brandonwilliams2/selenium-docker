# Java-Selenium-E2E-Test-Automation-Framework

## Dependencies:
Java 8

Selenium version 3.141.59

TestNG 7.4.0

WebDriverManager 4.4.3 
- WebDriverManager is a library which allows us to automate the management of the correct version of browser drivers (e.g. chromedriver, geckodriver, etc.) required by Selenium WebDriver.

## Project Structure:

This project has two source directories: src > main and src > test. 

### App.pages
- src > main > java > com.App.Pages
 
 Location of the Page class files for all pages of application under test

#### Page object
Each page object instance has a WebDriver instance passed in from the calling class (test class), and a new WebdriverWait instance (useful for waiting for Web Elements to display on the page) that accepts the driver and the max timeOutInSeconds as parameters.

Page objects also have private WebElement members that are mapped to Web Elements found on the corresponding page.

Page classes utilize public methods to allow other classes access to the private Web Elements. These public 'action' methods will form the building blocks for your tests.

### App.tests
- src > test > java > com.App.tests

Location of the test class files for all e2e tests

#### Test class
Each test class has private member variables that store the test parameters. The @BeforeTest and @Parameters annotations mean that before each test executes, the test parameters are passed in from the test suite .xml file. 

The @Test annotation signifies that the method is a test method. Each test method will utilize page objects and methods to interact with the app page and validate that it is behaving as expected. Each @Test method executes independently of other @Test methods. Test methods can be chained together to create longer e2e tests using @Test(dependsOnMethods = "<preceding-test-method-name>")

#### BaseTest class
Parent class for all test classes.

@BeforeTest and @AfterTest annotations mean these methods will run before and after each @Test method execution. 

The setupDriver method creates the WebDriver and shares it with the child test classes. It also sets the host ip / name.

The default WebDriver will be chrome unless the browser type is passed in by the user, by setting the "BROWSER" environment variable.

Likewise the defualt host property will be set to localhost unless the user provides it via "HUB_HOST" environment variable.

The tearDownDriver method brings down the current WebDriver instance.

### Test Suite
the test-suite.xml (see: 1-book-flight-feature.xml as an example) is where the data-driven test scenarios are defined with the necessary test data.

The parallel="tests" option will cause each test scenario with it's specific data parameters in the test-suite.xml to run at the same time (in parallel).

NOTE: When utilizing parallel="tests", Java will create a thread for each test in the suite and run them in parallel. However, in order for the tests to truly execute in parallel, you will have to 'scale-out' your selenium grid to ensure that there are enough browser instances for your tests to run on. See: Scaling Services on https://github.com/brandonwilliams2/selenium-test-runner.git - for more info on scaling your selenium grid.

### Building a Test docker image

#### pom.xml build

##### maven-compiler-plugin
specifies the java version for the source and testSource classes

#### maven-dependency-plugin
copies all dependencies needed to run the project and moves them to the */libs directory

#### maven-jar-plugin
packages the main and test classes 

When we build the project with 

2 jar files will be produced. The name of these files comes from the <finaalName> of the build section of the pom.xml

ex: `<finalName>java-selenium</finalName>` produces: java-selenium.jar, and java-selenium-test.jar



## Setup
1. First create the Page classes and 'action' methods for all pages in the app that will be tested.
2. Then create the Test classes and that will execute your test cases
3. Create the testng test suite .xml 
- Give the suite a name that describes the overall functionality being tested ex. "book-flight-feature"
- Give the test name a specific title that describes what this test is doing ex. "book-flight-2-passengers"
- The class name is the name of the test class created in step 2 ex. "com.BookFlightApp.tests.BookFlightTest"
- Define the test parameters for expected input and output - these parameters will be mapped to the setupParameters method in the test class

    - NOTE: parameters can be defined at 2 levels:
            
            Suite level – The parameters inside the <suite> tag of TestNG XML file will be a suite level parameter.
            Test Level — The parameters inside the <Test> tag of testing XML file will be a Test level parameter.
    - If you want to test multiple values of the same parameter use DataProviders. Data Provider in TestNG is a method used when a user needs to pass complex parameters. see: https://www.guru99.com/parameterization-using-xml-and-dataproviders-selenium.html

## Run tests locally
Right click on the test suite .xml file and select the 'Run' option
* To Debug tests: set break point and right click on the test suite .xml file and select the 'Debug' option





