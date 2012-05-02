class Raffler.Views.CompaniesIndex extends Backbone.View

  template: JST['companies/index']
  templateEntries: JST['']

  events:
    'click #drawMap': 'drawVisualisation'
    'click #drawMap2': 'drawMap2'
    'click #newMap': 'newMap'
    'submit .newChart': 'newChart'
    'click #drillDownChart': 'setChart'
    'click #newView': 'newView'
    'click #drawMarkersMap': 'drawMarkersMap'
    'click .carousel': 'carousel'

  initialize: ->
    @company = @collection[0]
    @company.on('reset', @render, this)
    @funding = @collection[1]
    @loadMaps()


  carousel: ->
    $(".carousel")[0].carousel() interval: 500


  render: ->
	  $(@el).html(@template(companies: @collection))
	  this

  renderEntries: ->
    $(@el).html(@templateEntries(companies: @collection))
    this

  drawVisualisation: ->
    chart = new Highcharts.Chart(
      chart:
        renderTo: this.$('#map')[0]
        plotBackgroundColor: null
        plotBorderWidth: null
        plotShadow: false

      title:
        text: "Funding of Theatre Companies"

      tooltip:
            formatter: ->
              "<b>" + @point.name + "</b>: " + @percentage + " %"

      plotOptions:
            pie:
              allowPointSelect: true
              cursor: "pointer"
              dataLabels:
                enabled: true
                color: "#000000"
                connectorColor: "#000000"
                formatter: ->
                  "<b>" + @point.name + "</b>: " + @percentage + " %"
      series: [
        type: "pie"
        name: "Funding Share"
        data: [ [ "Druid", 6.9 ], [ "Dublin Theatre Festival", 6.45 ],
          name: "Abbey"
          y: 58.99
          sliced: true
          selected: true
        ,[ "Fishamble", 2.02 ],[ "Gate", 8.22 ],[ "Irish Theatre Institue", 1.68 ],[ "Pan Pan Theatre", 1.93 ],[ "Rough Magic", 4.8 ],[ "Second Age", 1.34 ],[ "Theatre Forum", 1.05 ],[ "Others", 2.17 ] ]
      ]
    )
    ###options = {
      zoom: 6
      center: new google.maps.LatLng(39,-98)
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    @map = new google.maps.Map(this.$('#map')[0],options)
    this.$('#map')[0].innerHTML = @map###


  drawMap2: ->
    @loadMaps()

  drawMarkersMap:->
    data = new google.visualization.DataTable()
    data.addColumn "string", "City"
    data.addColumn "number", "Funding"
    data.addColumn "number", "Yeaar"
    data.addRows [
      [ "Cavan", 0, 2012 ],
      [ "Cork", 160000, 2012 ],
      [ "Dublin", 3195000, 2012 ],
      [ "Galway", 820000, 2012 ],
      [ "Kildare", 40000, 2012 ],
      [ "Meath", 40000, 2012 ],
      [ "Sligo", 210000, 2012 ]]
    options = {}
    options["region"]= "IE"
    options['colors']= ['#CCCCFF','#000033']
    options["dataMode"] = "markers"
    options["resolution"]= "provinces"

    selectHandler = (e) ->
      selection = chart.getSelection()
      row = selection[0].row
      alert "You selected " + data.getValue(row, 0)
      google.visualization.events.addListener geochart, "select", selectHandler

    chart = new google.visualization.GeoChart(this.$("#map")[0])
    chart.draw data, options

  loadMaps: ->
     google.load "visualization", "1",
       packages: ['geochart']
       callback: ->
         (CompaniesIndex.prototype.drawMarkersMap())


  newMap: ->
    $(@el).html(@template(companies: @collection))
    this

  newChart: (event) ->
    event.preventDefault()
    options =
      chart:
        renderTo: this.$('#map')[0]
        defaultSeriesType: "column"

      title:
        text: "Theatre Company Grants"

      xAxis:
        categories: []
        labels:
          rotation: -45
          align: "right"
          style:
            font: "normal 13px Arial"

      yAxis:
        title:
          text: "Amount"

      series: []

    series = data: []

    $.each @company.models, (i, company)->
        name = company.get('name')
        options.xAxis.categories.push(name)

    i = undefined
    company = undefined
    j = undefined
    funding = undefined
    i = 0
    while i < @company.models.length
      company = @company.models[i].get('fundings')
      j = 0
      while j < company.length
        if company[j].year == event.currentTarget[1].value
          amount = company[j].amount
          series.data.push(amount)
        j++
      i++

    options.series.push series
    chart = new Highcharts.Chart(options)

  setChart:->
    colors = Highcharts.getOptions().colors
    categories = []
    $.each @company.models, (i, company)->
      companyName = company.get('name')
      categories.push(companyName)

    name = "Theatre Company Funding"
    data = []

    i = undefined
    company = undefined
    j = undefined
    funding = undefined
    i = 0
    while i < @company.models.length
      company = @company.models[i].get('fundings')
      j = 0
      obj = {}
      obj.drilldown = {}
      obj.drilldown.categories =[]
      obj.drilldown.data = []

      while j < company.length
        if @company.models[i].get('id') == company[j].company_id
          amount = company[j].amount
          obj.drilldown.data.push(amount)
          category = company[j].year
          obj.drilldown.categories.push(category)
          obj.drilldown.name = @company.models[i].get('name')
          obj.drilldown.color = colors[i]
          if company[j].year ="2012"
            obj.y = company[j].amount
        j++
      data.push(obj)
      i++

    writeDetails = (name)->
        this.$('#details')[0].innerHTML = name

    drillDownChart = ( name, categories, data, color) ->
      chart.xAxis[0].setCategories categories
      chart.series[0].remove()
      chart.addSeries
        name: name
        data: data
        color: color

    chart = new Highcharts.Chart(
      chart:
        renderTo: this.$('#map')[0]
        type: "column"
      title:
        text: "Theatre Companies Funding"
      subtitle:
        text: "Click on the columns to find out about each company"

      xAxis:
        categories: categories
        labels:
          rotation: -45
          align: "right"
          style:
            font: "normal 13px Arial"

      yAxis:
        title:
          text: " Theatre Companies"

      plotOptions:
        series:
          events:
            legendItemClick: (event) ->
              name = this.name
              writeDetails name
              visibility = (if @visible then "visible" else "hidden")
              false  unless confirm("The series is currently " + visibility + ". Do you want to change that?")

        column:
          cursor: "pointer"
          point:
            events:
              click: ->
                drilldown = this.drilldown
                chartObj = this.chart
                if drilldown
                  drillDownChart drilldown.name, drilldown.categories, drilldown.data, drilldown.color
                else
                  drillDownChart name, categories, data

          dataLabels:
            enabled: true
            color: colors[0]
            style:
              fontWeight: "bold"

      tooltip:
        formatter: ->
          point = @point
          s = @x + ":<b>" + @y
          if point.drilldown
            s += "Click to view" + point.category
          else
            s += "Click to return to all theatre companies"
          s


      series: [
        name: name
        data: data
        color: "blue"]
    )

  newView: ->
    @renderEntries()

  pieChart: ->












