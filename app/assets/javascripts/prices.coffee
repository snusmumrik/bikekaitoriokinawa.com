# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#maker_id").change( ->
    if $("#engine_id").val() != ""
      # alert $("#engine_id").val()
      getBikeOptions()
  )

  $("#engine_id").change( ->
    if $("#maker_id").val() != ""
      # alert $("#maker_id").val()
      getBikeOptions()
  )

  $("#bike_id").change( ->
    getMeterOptions()
  )

  replaceBikeOptions = (results) ->
      $("#bike_id").html $('<option>')
      $.each results, ->
        option = $('<option>').val(this.id).text(this.name)
        $("#bike_id").append(option)

  getBikeOptions = ->
    $.ajax
      url: "/bikes?maker_id=#{$('#maker_id').val()}&engine_id=#{$('#engine_id').val()}"
      dataType: "json"
      success: (results) ->
        replaceBikeOptions(results)
      error: (XMLHttpRequest, textStatus, errorThrown) ->
        console.error("Error occurred in getBikeOptions")
        console.log("XMLHttpRequest: #{XMLHttpRequest.status}")
        console.log("textStatus: #{textStatus}")
        console.log("errorThrown: #{errorThrown}")

  replaceMeterOptions = (results) ->
      $("#year").html $()
      $.each results, ->
        if this.year == "不明もしくは指定なし"
          option = $('<option>').val(this.year).text(this.year)
        else if this.year == "1"
          option = $('<option>').val(this.year).text("#{1988 + Number(this.year)}年/平成元年")
        else
          option = $('<option>').val(this.year).text("#{1988 + Number(this.year)}年/平成#{this.year}年")
        $("#year").append(option)

  getMeterOptions = ->
    $.ajax
      url: "/meters?bike_id=#{$('#bike_id').val()}}"
      dataType: "json"
      success: (results) ->
        replaceMeterOptions(results)
      error: (XMLHttpRequest, textStatus, errorThrown) ->
        console.error("Error occurred in getMeterOptions")
        console.log("XMLHttpRequest: #{XMLHttpRequest.status}")
        console.log("textStatus: #{textStatus}")
        console.log("errorThrown: #{errorThrown}")