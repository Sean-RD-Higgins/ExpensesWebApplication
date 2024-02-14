<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ExpensesWebApplication._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main>
        <section class="row" aria-labelledby="aspnetTitle">
            <h1 id="aspnetTitle">DashExpenses</h1>
            <p class="lead">Shouldn't your expenses be handled swiftly?</p>
            <p><a href="app" class="btn btn-primary btn-md">Try it out here</a></p>
        </section>

        <div class="row">
            <section class="col-md-4" aria-labelledby="librariesTitle"> 
                <h2 id="librariesTitle">What Does DashExpenses Do?</h2>
                <ul>
                    <li>Enter all of your weekly, monthly, or daily expenses in this simple-to-use application!</li>
                    <li>Oil and gas prices changing all the time, so track the average with our Variable Expenses feature.</li>
                    <li>Have various incomes for your households?  We got you covered.  You can enter each individual income for your household.</li>
                    <li>Tips and commissions make your income difficult to track?  Enter them into our Variable Income section and we will average it for you.</li>
                    <li>Utilize the Dashboard to handle the breakdown and view your monthly net profit.</li>
                </ul>
                <p><a href="app" class="btn btn-primary btn-md">Try it out here</a></p>
            </section>
            <section class="col-md-4" aria-labelledby="gettingStartedTitle">
                <h2 id="gettingStartedTitle">The Making Of DashExpenses</h2>
                <ul>
                    <li>
                        A carefully crafted Requirements Document was created 
                        <a target="_blank" href="https://1drv.ms/w/s!AgmgeaIG079Thpwq1gSlDDlEQEydyA?e=x2VV3g">here.</a>
                    </li>
                    <li>
                        With simplicity in mind, the User Flow Diagram was created
                        <a target="_blank" href="https://lucid.app/lucidchart/9354b162-41ba-4cf4-9f09-a60983137655/edit?invitationId=inv_34b4cc0b-7df8-4c63-b913-ffcbc9849055">here.</a>
                    </li>
                    <li>We needed a place to put it, so we got some server space 
                        <a target="_blank" href="https://higgins.host/">here.</a>
                    </li>
                    <li>
                        We made a database to store the temporary data for the application and drafted its design 
                        <a target="_blank" href="https://miro.com/app/board/uXjVNtYMEq0=/?share_link_id=134844273239">
                            UNDER CONSTRUCTION.
                        </a>
                    </li>
                </ul>
            </section>
            <section class="col-md-4" aria-labelledby="gettingStartedTitle">
                <h2 id="gettingStartedTitle">Requirements Documentation</h2>
                <ul>
                    <li>Contains Product Context that ensures the solution requirements include all necessary functionality.</li>
                    <li>Also contains the User Classes And Characteristics, to display what roles will be executed to complete the application.</li>
                    <li>The Operating Environment lists the technical specifications to house the application.</li>
                    <li>The Business Drivers shows the objective the application is to solve.</li>
                    <li>Next are the Stakeholders, which define who owns the process to get the solution delivered. </li>
                    <li>Furthermore, the Requirements show what is expected of the solution when completed. </li>
                    <li>The Analysis Models section contains the list of any attached/referenced documentation, such as data flow diagrams, class diagrams, state-transition diagrams, and entity-relationship diagrams. </li>
                </ul>
                <div>
                    <a class="btn btn-default" href="https://1drv.ms/w/s!AgmgeaIG079Thpwq1gSlDDlEQEydyA?e=x2VV3g">
                        View the document here
                    </a>
                </div>
            </section>
        </div>

        <div class="row">
            <section class="col-md-4" aria-labelledby="librariesTitle">
                <h2 id="librariesTitle">Mockups</h2>
                <ul>
                    <li>
                        You can't just "start drawing" a page, you have to draft it first!  Check them out 
                        <a target="_blank" href="~/TODO_REPLACE_THIS">UNDER CONSTRUCTION.</a>
                    </li>
                    <li>
                        What about user experience?  That is just as important!  Check out the prototype  
                        <a target="_blank" href="~/TODO_REPLACE_THIS">UNDER CONSTRUCTION.</a>
                    </li>
                    <li>
                        But does everything link together nicely?  Take a look at this wireframe    
                        <a target="_blank" href="~/TODO_REPLACE_THIS">UNDER CONSTRUCTION.</a>
                    </li>
                </ul>
            </section>
            <section class="col-md-4" aria-labelledby="gettingStartedTitle">
                <h2 id="gettingStartedTitle">Quality Assurance</h2>
                <ul>
                    <li>
                        Test Plan: 
                        <a target="_blank" href="~/TODO_REPLACE_THIS">UNDER CONSTRUCTION.</a>
                    </li>
                    <li>
                        Test Cases: 
                        <a target="_blank" href="~/TODO_REPLACE_THIS">UNDER CONSTRUCTION.</a>
                    </li>
                    <li>
                        Everything Else: 
                        <a target="_blank" href="~/TODO_REPLACE_THIS">UNDER CONSTRUCTION.</a>
                    </li>
                </ul>
            </section>
            <section class="col-md-4" aria-labelledby="gettingStartedTitle">
                <h2 id="gettingStartedTitle">Techy Stuff!</h2>
                <ul>
                    <li>
                        Let's get technical!  You can find the code located 
                        <a href="https://github.com/Sean-RD-Higgins/ExpensesWebApplication/blob/master/ExpensesLibrary/Strategy/ExpenseStrategy.cs#L11">here.</a>
                    </li>
                    <li>
                        If you are looking specifically for the style rules, it is  
                        <a href="https://github.com/Sean-RD-Higgins/ExpensesWebApplication/blob/master/ExpensesWebApplication/App.aspx#L5">here.</a>
                    </li>
                    <li>
                        The front end is important too of course, which can be seen  
                        <a href="https://github.com/Sean-RD-Higgins/ExpensesWebApplication/blob/master/ExpensesWebApplication/App.aspx#L260">here.</a>
                    </li>
                    <li>
                        Interest in the client side javascript can go 
                        <a href="https://github.com/Sean-RD-Higgins/ExpensesWebApplication/blob/master/ExpensesWebApplication/App.aspx#L46">here.</a>
                    </li>
                </ul>
            </section>
        </div>
    </main>

</asp:Content>
