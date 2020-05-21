dashboardPage(skin = "black",
  dashboardHeader(title = "Plastic Waste and Its Mismanagement"),
  dashboardSidebar(sidebarMenu(
    menuItem("Problem", tabName = "prob", icon = icon("exclamation-triangle")),
    menuItem("Causes", tabName = "cause", icon = icon("question-circle")),
    menuItem("Impact", tabName = "imp", icon = icon("tint-slash")))),
  dashboardBody(
    tabItems(
      tabItem(tabName = "prob",
              box(width = 12, title = "Introduction", background = "black", "Plastic is a synthetic organic polymer made from petroleum with properties ideally suited for a wide variety of applications, including packaging, building and construction, household and sports equipment, vehicles, electronics and agriculture. Plastic is cheap, lightweight, strong and malleable. Over 300 million tons of plastic are produced every year, half of which is used to design single-use items such as shopping bags, cups and straws. While plastic has many valuable uses, we have become addicted to single-use or disposable plastic — with severe environmental consequences.
Around the world, one million plastic drinking bottles are purchased every minute, while up to 5 trillion single-use plastic bags are used worldwide every year. In total, half of all plastic produced is designed to be used only once — and then thrown away.
Plastic waste is now so ubiquitous in the natural environment that scientists have even suggested it could serve as a geological indicator of the Anthropocene era.
So how did we get here?"),
              fluidRow(
                box(width = 3, title = "Inputs", background = "black", height = "300px", radioButtons(inputId = "asc",
                                 label = "", choices = c("Ascending", "Descending", "Based on consecutive years"), selected = "Ascending")),
                box(width = 9, title = "Trend of the amount of plastic produced annually", background = "red", solidHeader = TRUE, height = "850px", plotlyOutput(outputId = "plastic", height = "800px"))
              ),
              fluidRow(
                box(width = 3, title = "Inputs", background = "black", height = "300px", selectInput(inputId = "choice", label = "Choose a country", choices = inadequately_managed$Entity)
              ),
              box(width = 9, title = "Percentage of plastic inadequately managed", background = "red", solidHeader = TRUE, height = "450px", plotOutput(outputId = "pie")),
              box(width = 12, title = "", valueBoxOutput("Good"),
                  valueBoxOutput("Bad"),
                  valueBoxOutput("Worst")))),
              
          tabItem(tabName= "cause", 
            fluidPage(navlistPanel(
              tabPanel("Low GDP",
                       box(width = 12, background = "black", "One of the cause of this problem is due to low GDP. Countries with low GDP tend to neglect environmental concerns. Put simply, poor people are
willing to sacrifice clean water and air, healthy forests, and wildlife habitat for economic growth. On the other hand, countries with high GDP has the time and ability to start focusing on environmental conservation.",
                       
                       "Below is the data from 2010 that supports this argument."),
                       box(width = 12, solidHeader = TRUE, height = "450px", plotlyOutput(outputId = "gdpmis")), 
                       box(width = 12, background = "black", "The negative gradient of the line above shows the inverse relationship between GDP and environmental conservation efforts. The higher the GDP per capita, the lesser the amount of mismanaged plastic, whereas the lower the GDP per capita, the higher the amount of mismanaged plastic. This fortifies the argument that low GDP is one of the causes of this phenomenon.")),
              tabPanel("Handling issues",
                       box(width = 12, background = "black", "Another cause would be the unawareness that countries have regarding methods to handle plastic waste. Although countries have more knowledge on how to handle plastic waste properly, such efforts are just simply not enough as a huge number of plastic is still improperly incinerated and discarded, bringing about even more environmental problems."),
                       box(width = 12, plotlyOutput(outputId = "overall")),
                       box(width = 12, sliderInput(inputId = "slide", label = "Choose a year", min = min(fatenews$Year),
                                   max = max(fatenews$Year), value = max(fatenews$Year)), plotOutput(outputId = "handling")),
                      box(width = 12, title = "", valueBoxOutput("Discarded"),
                      valueBoxOutput("Incinerated"),
                      valueBoxOutput("Recycled")))))),
      tabItem(tabName = "imp", height = "2000px",
              fluidRow(box(width = 12, title = "Impact on the Ocean", background = "black", "According to the United Nations, it is estimated that up to 13 million metric tons of plastic ends up in the ocean each year—the equivalent of a rubbish or garbage truck load’s worth every minute. This has certainly polluted our oceans and killed many living marine animals. Below is the data that predicts the amount of macroplastics and microplastics in our ocean based on three scenarios: 1) emissions to the oceans stop in 2020; (2) they
stagnate at 2020 emission rates; or (3) continue to grow until 2050 in line with historical plastic production rates.")), 
              fluidRow(box(width = 3, title = "Inputs", background = "black", height = "300px", radioButtons(inputId = "buttons", label = "",
                           choices = c("Macroplastics", "Microplastics"), selected = "Macroplastics")),
              box(width = 9, background = "red", solidHeader = TRUE, height = "450px", plotlyOutput(outputId = "sea"))),
              fluidRow(box(width = 12, background = "black", "Below is the map that shows the amount of plastic waste on the surface of the world's oceans in the year 2013 alone.")),
              fluidRow(box(width = 12, leafletOutput(outputId = "leaflet"))),
              fluidRow(box(width = 12, title = "", infoBoxOutput("Global", width = 6), infoBox("Worst Polluted Ocean", "North Pacific Ocean", icon = icon("fish"), color = "purple", fill = FALSE, width = 6))),
              fluidRow(box(width = 12, background = "black", title = "Impact on coral reefs", "The pollution of oceans can affect marine life negatively. One of such species would be the coral reefs that act as habitats of many other marine animals. Below is the result of an experiment conducted, where the corals are subjected to a controlled environment as well as an environment full of plastic, to determine the effect of plastic waste on the growth of the corals.")),
              fluidRow(box(width = 3, title = "Inputs", background = "black", height = "200px", selectInput(inputId = "selector", label = "", choices = c("Surface area", "Weight", "Volume"), selected = "Surface area")),
              box(width = 9, background = "red", solidHeader = TRUE, height = "450px", plotlyOutput(outputId = "New"))),
              fluidRow(box(width = 12, background = "black", "The above result shows how plastic waste prevents coral reefs from growing to its full size, in terms of surface area, weight and volume, compared to when it is in an ideal and controlled environment, with some exception of corals with the genus 'Pocillopora'. This shows just how harmful and detrimental plastic waste are to our coral reefs."))
              
              
              
              
              ))))