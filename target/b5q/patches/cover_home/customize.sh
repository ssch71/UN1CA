# The Flip5 cover screen is a second built-in (TYPE_INTERNAL) display. The
# S23-based services.jar treats it like a DeX/external display and keeps
# launching SECONDARY_HOME (HoneySpace SecondaryLauncher) on it, which the
# launcher immediately finishes ("do not create in device display(1)"). The
# resulting relaunch loop pegs system_server, heats the device and makes the
# home screen flicker. Never place a secondary home on a built-in display.
SMALI_PATCH "system" "system/framework/services.jar" \
    "smali_classes2/com/android/server/wm/RootWindowContainer.smali" "replace" \
    "shouldPlaceSecondaryHomeOnDisplayArea(Lcom/android/server/wm/TaskDisplayArea;)Z" \
    "invoke-virtual {p1}, Lcom/android/server/wm/TaskDisplayArea;->canHostHomeTask()Z" \
    "    iget-object v0, p1, Lcom/android/server/wm/WindowContainer;->mDisplayContent:Lcom/android/server/wm/DisplayContent;\n\n    iget-object v0, v0, Lcom/android/server/wm/DisplayContent;->mDisplay:Landroid/view/Display;\n\n    invoke-virtual {v0}, Landroid/view/Display;->getType()I\n\n    move-result v0\n\n    const/4 v2, 0x1\n\n    if-ne v0, v2, :cond_unica_cover_home\n\n    return v1\n\n    :cond_unica_cover_home\n    invoke-virtual {p1}, Lcom/android/server/wm/TaskDisplayArea;->canHostHomeTask()Z"
