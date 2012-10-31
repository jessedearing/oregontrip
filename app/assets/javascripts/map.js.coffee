class @Map
  constructor: (lat, lon)->
    @lat = lat
    @lon = lon
  gaLatLon: ->
    new google.maps.LatLng(@lat, @lon)
  gaRenderMap: (mapdiv) ->
    mapOptions = {
      zoom: 8
      center: this.gaLatLon()
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }

    mdiv = document.getElementById(mapdiv)

    @map = new google.maps.Map(mdiv, mapOptions)

    @marker = new google.maps.Marker({
      position: this.gaLatLon()
      map: @map
    })
