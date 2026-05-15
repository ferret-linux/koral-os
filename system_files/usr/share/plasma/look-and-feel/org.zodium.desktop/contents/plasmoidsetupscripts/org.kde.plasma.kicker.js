if ( applet.readConfig("icon", "start-here-kde") == "start-here-kde" ) {
  applet.currentConfigGroup = ["General"]
  applet.writeConfig("icon", "start-here");
}
