.class public final Lio/mesalabs/unica/UnicaL10n;
.super Ljava/lang/Object;
.source "UnicaL10n.java"

# UN1CA: Korean strings for the UN1CA Settings screens that are built in code.

.field private static sMap:Ljava/util/HashMap;

.method public static t(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    if-nez p0, :cond_0

    return-object p0

    :cond_0
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v0

    const-string v1, "ko"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    return-object p0

    :cond_1
    invoke-static {}, Lio/mesalabs/unica/UnicaL10n;->map()Ljava/util/HashMap;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_2

    return-object p0

    :cond_2
    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method private static declared-synchronized map()Ljava/util/HashMap;
    .locals 1

    sget-object v0, Lio/mesalabs/unica/UnicaL10n;->sMap:Ljava/util/HashMap;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    invoke-static {v0}, Lio/mesalabs/unica/UnicaL10n;->fill0(Ljava/util/HashMap;)V

    invoke-static {v0}, Lio/mesalabs/unica/UnicaL10n;->fill1(Ljava/util/HashMap;)V

    invoke-static {v0}, Lio/mesalabs/unica/UnicaL10n;->fill2(Ljava/util/HashMap;)V

    invoke-static {v0}, Lio/mesalabs/unica/UnicaL10n;->fill3(Ljava/util/HashMap;)V

    invoke-static {v0}, Lio/mesalabs/unica/UnicaL10n;->fill4(Ljava/util/HashMap;)V

    invoke-static {v0}, Lio/mesalabs/unica/UnicaL10n;->fill5(Ljava/util/HashMap;)V

    sput-object v0, Lio/mesalabs/unica/UnicaL10n;->sMap:Ljava/util/HashMap;

    :cond_0
    return-object v0
.end method

.method private static fill0(Ljava/util/HashMap;)V
    .locals 2

    const-string v0, "\nApp-state changes await restart."

    const-string v1, "\n\uc571 \uc0c1\ud0dc \ubcc0\uacbd\uc740 \ub2e4\uc2dc \uc2dc\uc791\ud55c \ub4a4 \uc801\uc6a9\ub429\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "\nComplete values to write:\n"

    const-string v1, "\n\uae30\ub85d\ud560 \uc804\uccb4 \uac12:\n"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "\nExperimental values can freeze the GPU or prevent booting. Requests are not millivolts; the driver rounds to available corners. Raw request 1 is not a standard named corner. Neither stock nor red values guarantee stability. Keep the matching recovery rollback available."

    const-string v1, "\n\uc2e4\ud5d8\uc801 \uac12\uc740 GPU\ub97c \uba48\ucd94\uac8c \ud558\uac70\ub098 \ubd80\ud305\uc744 \ub9c9\uc744 \uc218 \uc788\uc2b5\ub2c8\ub2e4. \uc694\uccad \uac12\uc740 \ubc00\ub9ac\ubcfc\ud2b8\uac00 \uc544\ub2c8\uba70 \ub4dc\ub77c\uc774\ubc84\uac00 \uc0ac\uc6a9 \uac00\ub2a5\ud55c \ucf54\ub108\ub85c \ub9de\ucda5\ub2c8\ub2e4. \uc6d0\uc2dc \uc694\uccad \uac12 1\uc740 \ud45c\uc900 \ucf54\ub108\uac00 \uc544\ub2d9\ub2c8\ub2e4. \uc21c\uc815 \uac12\ub3c4 \ube68\uac04 \uac12\ub3c4 \uc548\uc815\uc131\uc744 \ubcf4\uc7a5\ud558\uc9c0 \uc54a\uc2b5\ub2c8\ub2e4. \ub9de\ub294 \ub9ac\ucee4\ubc84\ub9ac \ub864\ubc31\uc744 \uc900\ube44\ud574 \ub450\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "\nKernel: "

    const-string v1, "\n\ucee4\ub110: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "\nRelease: "

    const-string v1, "\n\ub9b4\ub9ac\uc2a4: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "\nRestoration incomplete. Retry with Battery Saving off."

    const-string v1, "\n\ubcf5\uc6d0\uc774 \ub05d\ub098\uc9c0 \uc54a\uc558\uc2b5\ub2c8\ub2e4. \ubc30\ud130\ub9ac \uc808\uc57d\uc744 \ub044\uace0 \ub2e4\uc2dc \uc2dc\ub3c4\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "\nTable "

    const-string v1, "\n\ud14c\uc774\ube14 "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, " (not "

    const-string v1, " (\uc544\ub2d8: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, " selected"

    const-string v1, "\uac1c \uc120\ud0dd\ub428"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, " \u00b7 Original: "

    const-string v1, " \u00b7 \uc6d0\ub798 \uac12: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, " \u00b7 Power level "

    const-string v1, " \u00b7 \uc804\ub825 \ub2e8\uacc4 "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, " \u00b7 Requested: "

    const-string v1, " \u00b7 \uc694\uccad \uac12: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, " \u00b7 minimum "

    const-string v1, " \u00b7 \ucd5c\uc18c "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "\"reduce transparency\" is on in the accessibility settings"

    const-string v1, "\uc811\uadfc\uc131 \uc124\uc815\uc5d0\uc11c \"\ud22c\uba85\ub3c4 \uc904\uc774\uae30\"\uac00 \ucf1c\uc838 \uc788\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "% battery"

    const-string v1, "% \ubc30\ud130\ub9ac"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "% remaining"

    const-string v1, "% \ub0a8\uc74c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, ". Keep the device powered\u2026"

    const-string v1, ". \uae30\uae30 \uc804\uc6d0\uc744 \ucf1c \ub454 \ucc44\ub85c \uae30\ub2e4\ub9ac\uc138\uc694\u2026"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, ". Refresh status before any further action."

    const-string v1, ". \ub2e4\ub978 \uc791\uc5c5\uc744 \ud558\uae30 \uc804\uc5d0 \uc0c1\ud0dc\ub97c \uc0c8\ub85c \uace0\uce58\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, ". Rollback export: "

    const-string v1, ". \ub864\ubc31 \ub0b4\ubcf4\ub0b4\uae30: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, ". Your tuning profile stays saved."

    const-string v1, ". \ud29c\ub2dd \ud504\ub85c\ud544\uc740 \uadf8\ub300\ub85c \uc800\uc7a5\ub3fc \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "; requested bucket is not effective"

    const-string v1, "; \uc694\uccad\ud55c \ub300\uae30 \ubc84\ud0b7\uc774 \uc801\uc6a9\ub418\uc9c0 \uc54a\uc558\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "ACD cell (decimal/0x hex, or none)"

    const-string v1, "ACD \uc140 (10\uc9c4\uc218/0x 16\uc9c4\uc218, \ub610\ub294 none)"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "ACD changed; "

    const-string v1, "ACD \ubcc0\uacbd\ub428; "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Accessibility apps"

    const-string v1, "\uc811\uadfc\uc131 \uc571"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Accessibility \u2014 hide settings and service lists"

    const-string v1, "\uc811\uadfc\uc131 \u2014 \uc124\uc815\uacfc \uc11c\ube44\uc2a4 \ubaa9\ub85d \uc228\uae30\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Action"

    const-string v1, "\ub3d9\uc791"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Action unavailable"

    const-string v1, "\uc0ac\uc6a9\ud560 \uc218 \uc5c6\ub294 \ub3d9\uc791"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Action: "

    const-string v1, "\ub3d9\uc791: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Active"

    const-string v1, "\ud65c\uc131"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Active (10)"

    const-string v1, "\ud65c\uc131 (10)"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Add power level"

    const-string v1, "\uc804\ub825 \ub2e8\uacc4 \ucd94\uac00"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Added power level. "

    const-string v1, "\uc804\ub825 \ub2e8\uacc4\ub97c \ucd94\uac00\ud588\uc2b5\ub2c8\ub2e4. "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Advanced GPU Tuning"

    const-string v1, "\uace0\uae09 GPU \ud29c\ub2dd"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Advanced GPU Tuning (Konabess)"

    const-string v1, "\uace0\uae09 GPU \ud29c\ub2dd (KonaBess)"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Aggressive restrictions cover all eligible user and system apps, including Play services and both stores. Selected apps below are additional targets, not exceptions."

    const-string v1, "\uac15\ub825 \uc81c\ud55c\uc740 Play \uc11c\ube44\uc2a4\uc640 \ub450 \uc2a4\ud1a0\uc5b4\ub97c \ud3ec\ud568\ud574 \ub300\uc0c1\uc774 \ub418\ub294 \ubaa8\ub4e0 \uc0ac\uc6a9\uc790\u00b7\uc2dc\uc2a4\ud15c \uc571\uc5d0 \uc801\uc6a9\ub429\ub2c8\ub2e4. \uc544\ub798\uc5d0\uc11c \uc120\ud0dd\ud55c \uc571\uc740 \uc608\uc678\uac00 \uc544\ub2c8\ub77c \ucd94\uac00 \ub300\uc0c1\uc785\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Android default"

    const-string v1, "Android \uae30\ubcf8\uac12"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Animator duration"

    const-string v1, "\uc560\ub2c8\uba54\uc774\ud130 \uae38\uc774"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "App"

    const-string v1, "\uc571"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Apply"

    const-string v1, "\uc801\uc6a9"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Apply GPU table"

    const-string v1, "GPU \ud14c\uc774\ube14 \uc801\uc6a9"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Apply custom restrictions?"

    const-string v1, "\uc0ac\uc6a9\uc790 \uc9c0\uc815 \uc81c\ud55c\uc744 \uc801\uc6a9\ud560\uae4c\uc694?"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Apply trial"

    const-string v1, "\uc2dc\ud5d8 \uc801\uc6a9"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Assign one action to each tile, then add it to Quick Settings. Hold a tile to edit it."

    const-string v1, "\ud0c0\uc77c\ub9c8\ub2e4 \ub3d9\uc791\uc744 \ud558\ub098\uc529 \uc9c0\uc815\ud55c \ub4a4 \ube60\ub978 \uc124\uc815\uc5d0 \ucd94\uac00\ud558\uc138\uc694. \ud0c0\uc77c\uc744 \uae38\uac8c \ub204\ub974\uba74 \ud3b8\uc9d1\ud560 \uc218 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Automatic"

    const-string v1, "\uc790\ub3d9"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Back up profile"

    const-string v1, "\ud504\ub85c\ud544 \ubc31\uc5c5"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Backups contain your choices, not device paths or original system values. Restore validates the file and leaves Battery Saving off until you enable it."

    const-string v1, "\ubc31\uc5c5\uc5d0\ub294 \uc120\ud0dd\ud55c \uc124\uc815\ub9cc \ub4e4\uc5b4\uac00\uba70 \uae30\uae30 \uacbd\ub85c\ub098 \uc6d0\ub798 \uc2dc\uc2a4\ud15c \uac12\uc740 \ub4e4\uc5b4\uac00\uc9c0 \uc54a\uc2b5\ub2c8\ub2e4. \ubcf5\uc6d0\ud558\uba74 \ud30c\uc77c\uc744 \uac80\uc0ac\ud558\uace0, \uc9c1\uc811 \ucf1c\uae30 \uc804\uae4c\uc9c0 \ubc30\ud130\ub9ac \uc808\uc57d\uc740 \uaebc\uc9c4 \uc0c1\ud0dc\ub85c \ub461\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Balanced preserves kernel and memory defaults and reports freezer state. Efficiency selects an advertised CPU ceiling near 85% of the original fastest-cluster limit; battery benefit needs measurement. Refresh-rate limiting stays optional. NOSLEN reproduces the module\'s intended settings. Stingy uses the lowest usable clocks and refresh rate, restricts user and non-essential system apps including Play services and both app stores, disables auto-sync, dims the screen, removes animations and enables dark mode. Severe performance and background-function loss are intentional."

    const-string v1, "Balanced\ub294 \ucee4\ub110\uacfc \uba54\ubaa8\ub9ac \uae30\ubcf8\uac12\uc744 \uc720\uc9c0\ud558\uace0 \ud504\ub9ac\uc800 \uc0c1\ud0dc\ub97c \ubcf4\uc5ec\uc90d\ub2c8\ub2e4. Efficiency\ub294 \uac00\uc7a5 \ube60\ub978 \ud074\ub7ec\uc2a4\ud130 \uc6d0\ub798 \ud55c\ub3c4\uc758 \uc57d 85%\uc5d0 \ud574\ub2f9\ud558\ub294 CPU \uc0c1\ud55c\uc744 \uace0\ub974\uba70, \ubc30\ud130\ub9ac \ud6a8\uacfc\ub294 \uc9c1\uc811 \uce21\uc815\ud574\ubd10\uc57c \ud569\ub2c8\ub2e4. \uc8fc\uc0ac\uc728 \uc81c\ud55c\uc740 \uc120\ud0dd \uc0ac\ud56d\uc785\ub2c8\ub2e4. NOSLEN\uc740 \uc6d0\ub798 \ubaa8\ub4c8\uc774 \uc758\ub3c4\ud55c \uc124\uc815\uc744 \uadf8\ub300\ub85c \uc801\uc6a9\ud569\ub2c8\ub2e4. Stingy\ub294 \uc0ac\uc6a9\ud560 \uc218 \uc788\ub294 \uac00\uc7a5 \ub0ae\uc740 \ud074\ub7ed\uacfc \uc8fc\uc0ac\uc728\uc744 \uc4f0\uace0, Play \uc11c\ube44\uc2a4\uc640 \ub450 \uc571 \uc2a4\ud1a0\uc5b4\ub97c \ud3ec\ud568\ud55c \uc0ac\uc6a9\uc790 \uc571\uacfc \ud544\uc218\uac00 \uc544\ub2cc \uc2dc\uc2a4\ud15c \uc571\uc744 \uc81c\ud55c\ud558\uba70, \uc790\ub3d9 \ub3d9\uae30\ud654\ub97c \ub044\uace0 \ud654\uba74\uc744 \uc5b4\ub461\uac8c \ud558\uace0 \uc560\ub2c8\uba54\uc774\uc158\uc744 \uc5c6\uc560\uace0 \ub2e4\ud06c \ubaa8\ub4dc\ub97c \ucf2d\ub2c8\ub2e4. \uc131\ub2a5\uacfc \ubc31\uadf8\ub77c\uc6b4\ub4dc \uae30\ub2a5\uc774 \ud06c\uac8c \ub5a8\uc5b4\uc9c0\ub294 \uac83\uc740 \uc758\ub3c4\ub41c \ub3d9\uc791\uc785\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Battery Saving"

    const-string v1, "\ubc30\ud130\ub9ac \uc808\uc57d"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Bluetooth device"

    const-string v1, "\ube14\ub8e8\ud22c\uc2a4 \uae30\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Boot into OrangeFox using the device\'s recovery procedure. Mount Cache. Flash /cache/unica-gpu/rollback.zip, or flash the saved rollback ZIP from USB/PC storage. It verifies and restores the exact pre-trial vendor_boot image. Reboot manually after success. Keep a matching full ROM available if recovery restoration fails. Never use this ZIP after changing firmware."

    const-string v1, "\uae30\uae30\uc758 \ub9ac\ucee4\ubc84\ub9ac \uc9c4\uc785 \ubc29\ubc95\uc73c\ub85c OrangeFox\uc5d0 \ub4e4\uc5b4\uac00\uc138\uc694. Cache\ub97c \ub9c8\uc6b4\ud2b8\ud558\uace0 /cache/unica-gpu/rollback.zip\uc744 \ud50c\ub798\uc2dc\ud558\uac70\ub098, USB/PC\uc5d0 \uc800\uc7a5\ud574 \ub454 \ub864\ubc31 ZIP\uc744 \ud50c\ub798\uc2dc\ud558\uc138\uc694. \uc2dc\ud5d8 \uc801\uc6a9 \uc804\uc758 vendor_boot \uc774\ubbf8\uc9c0\ub97c \uac80\uc99d\ud55c \ub4a4 \uadf8\ub300\ub85c \ubcf5\uc6d0\ud569\ub2c8\ub2e4. \uc131\uacf5\ud558\uba74 \uc9c1\uc811 \uc7ac\ubd80\ud305\ud558\uc138\uc694. \ub9ac\ucee4\ubc84\ub9ac \ubcf5\uc6d0\uc774 \uc2e4\ud328\ud560 \uacbd\uc6b0\ub97c \ub300\ube44\ud574 \uac19\uc740 \ubc84\uc804\uc758 \uc804\uccb4 \ub86c\uc744 \uc900\ube44\ud574 \ub450\uc138\uc694. \ud38c\uc6e8\uc5b4\ub97c \ubc14\uafbc \ub4a4\uc5d0\ub294 \uc774 ZIP\uc744 \uc808\ub300 \uc0ac\uc6a9\ud558\uc9c0 \ub9c8\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Both tables are stored in firmware. The driver chooses the active table by chip/SKU; choosing a table here only chooses which draft to edit. Up to 15 entries per table, within the original FDT space. RPMh requests are mapped to available command-DB corners, not millivolts. Red marks values outside stock. None of these settings are a stability guarantee."

    const-string v1, "\ub450 \ud14c\uc774\ube14 \ubaa8\ub450 \ud38c\uc6e8\uc5b4\uc5d0 \uc800\uc7a5\ub3fc \uc788\uc2b5\ub2c8\ub2e4. \uc2e4\uc81c\ub85c \uc4f0\uc77c \ud14c\uc774\ube14\uc740 \ub4dc\ub77c\uc774\ubc84\uac00 \uce69/SKU\uc5d0 \ub530\ub77c \uace0\ub974\uba70, \uc5ec\uae30\uc11c \ud14c\uc774\ube14\uc744 \uace0\ub974\ub294 \uac74 \uc5b4\ub5a4 \ucd08\uc548\uc744 \ud3b8\uc9d1\ud560\uc9c0\ub9cc \uc815\ud569\ub2c8\ub2e4. \ud14c\uc774\ube14\ub9c8\ub2e4 \uc6d0\ub798 FDT \uacf5\uac04 \uc548\uc5d0\uc11c \ucd5c\ub300 15\uac1c \ud56d\ubaa9\uae4c\uc9c0 \ub123\uc744 \uc218 \uc788\uc2b5\ub2c8\ub2e4. RPMh \uc694\uccad \uac12\uc740 \ubc00\ub9ac\ubcfc\ud2b8\uac00 \uc544\ub2c8\ub77c command-DB\uc758 \uc0ac\uc6a9 \uac00\ub2a5\ud55c \ucf54\ub108\ub85c \ub300\uc751\ub429\ub2c8\ub2e4. \ube68\uac04\uc0c9\uc740 \uc21c\uc815 \ubc94\uc704\ub97c \ubc97\uc5b4\ub09c \uac12\uc785\ub2c8\ub2e4. \uc5b4\ub5a4 \uc124\uc815\ub3c4 \uc548\uc815\uc131\uc744 \ubcf4\uc7a5\ud558\uc9c0 \uc54a\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Bus "

    const-string v1, "\ubc84\uc2a4 "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Bus and ACD \u00b7 level "

    const-string v1, "\ubc84\uc2a4 \ubc0f ACD \u00b7 \ub2e8\uacc4 "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Bus frequency index"

    const-string v1, "\ubc84\uc2a4 \uc8fc\ud30c\uc218 \uc778\ub371\uc2a4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Bus maximum index"

    const-string v1, "\ubc84\uc2a4 \ucd5c\ub300 \uc778\ub371\uc2a4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Bus minimum index"

    const-string v1, "\ubc84\uc2a4 \ucd5c\uc18c \uc778\ub371\uc2a4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "CPU ceiling \u00b7 "

    const-string v1, "CPU \uc0c1\ud55c \u00b7 "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Cached-process effective limit unavailable"

    const-string v1, "\uce90\uc2dc \ud504\ub85c\uc138\uc2a4 \uc2e4\uc81c \ud55c\ub3c4\ub97c \ud655\uc778\ud560 \uc218 \uc5c6\uc74c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Camera"

    const-string v1, "\uce74\uba54\ub77c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Camera & microphone in use"

    const-string v1, "\uce74\uba54\ub77c\u00b7\ub9c8\uc774\ud06c \uc0ac\uc6a9 \uc911"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Camera in use"

    const-string v1, "\uce74\uba54\ub77c \uc0ac\uc6a9 \uc911"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Cancel"

    const-string v1, "\ucde8\uc18c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Cannot add level"

    const-string v1, "\ub2e8\uacc4\ub97c \ucd94\uac00\ud560 \uc218 \uc5c6\uc74c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Cannot apply"

    const-string v1, "\uc801\uc6a9\ud560 \uc218 \uc5c6\uc74c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Cannot enumerate background apps: "

    const-string v1, "\ubc31\uadf8\ub77c\uc6b4\ub4dc \uc571 \ubaa9\ub85d\uc744 \ubd88\ub7ec\uc62c \uc218 \uc5c6\uc74c: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Cannot initialize tuning profile: "

    const-string v1, "\ud29c\ub2dd \ud504\ub85c\ud544\uc744 \ucd08\uae30\ud654\ud560 \uc218 \uc5c6\uc74c: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Cannot load values"

    const-string v1, "\uac12\uc744 \ubd88\ub7ec\uc62c \uc218 \uc5c6\uc74c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Cannot remove level"

    const-string v1, "\ub2e8\uacc4\ub97c \uc0ad\uc81c\ud560 \uc218 \uc5c6\uc74c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Cannot save island settings. The rules or app list may be too large."

    const-string v1, "\uc544\uc77c\ub79c\ub4dc \uc124\uc815\uc744 \uc800\uc7a5\ud560 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4. \uaddc\uce59\uc774\ub098 \uc571 \ubaa9\ub85d\uc774 \ub108\ubb34 \ud074 \uc218 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Cannot save profile"

    const-string v1, "\ud504\ub85c\ud544\uc744 \uc800\uc7a5\ud560 \uc218 \uc5c6\uc74c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Cannot save voltage request"

    const-string v1, "\uc804\uc555 \uc694\uccad \uac12\uc744 \uc800\uc7a5\ud560 \uc218 \uc5c6\uc74c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Changes take effect after reboot. Unsuitable values can cause freezes or prevent booting. Keep your recovery rollback available."

    const-string v1, "\ubcc0\uacbd \uc0ac\ud56d\uc740 \uc7ac\ubd80\ud305 \ud6c4 \uc801\uc6a9\ub429\ub2c8\ub2e4. \ub9de\uc9c0 \uc54a\ub294 \uac12\uc740 \uba48\ucda4\uc774\ub098 \ubd80\ud305 \ubd88\uac00\ub97c \uc77c\uc73c\ud0ac \uc218 \uc788\uc2b5\ub2c8\ub2e4. \ub9ac\ucee4\ubc84\ub9ac \ub864\ubc31\uc744 \uc900\ube44\ud574 \ub450\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Charging"

    const-string v1, "\ucda9\uc804 \uc911"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Choose Exempted App"

    const-string v1, "\uc608\uc678 \uc571 \uc120\ud0dd"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Choose a downloaded update and check compatibility"

    const-string v1, "\ub2e4\uc6b4\ub85c\ub4dc\ud55c \uc5c5\ub370\uc774\ud2b8\ub97c \uace8\ub77c \ud638\ud658\uc131\uc744 \ud655\uc778\ud558\uc138\uc694"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Choose an action"

    const-string v1, "\ub3d9\uc791 \uc120\ud0dd"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Choose an app shortcut"

    const-string v1, "\uc571 \ubc14\ub85c\uac00\uae30 \uc120\ud0dd"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Choose an installed app"

    const-string v1, "\uc124\uce58\ub41c \uc571 \uc120\ud0dd"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Choose apps for full restrictions"

    const-string v1, "\uc804\uccb4 \uc81c\ud55c\ud560 \uc571 \uc120\ud0dd"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Choose apps for standby only"

    const-string v1, "\ub300\uae30\ub9cc \uc81c\ud55c\ud560 \uc571 \uc120\ud0dd"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Choose exemptions to remove"

    const-string v1, "\uc0ad\uc81c\ud560 \uc608\uc678 \uc120\ud0dd"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Choose target"

    const-string v1, "\ub300\uc0c1 \uc120\ud0dd"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Clear this tile\'s action and label?"

    const-string v1, "\uc774 \ud0c0\uc77c\uc758 \ub3d9\uc791\uacfc \uc774\ub984\uc744 \uc9c0\uc6b8\uae4c\uc694?"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Compatible firmware. Backup: "

    const-string v1, "\ud638\ud658\ub418\ub294 \ud38c\uc6e8\uc5b4\uc785\ub2c8\ub2e4. \ubc31\uc5c5: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Configuration saved. You can also add the tile using Quick Settings \u2192 Edit."

    const-string v1, "\uc124\uc815\uc744 \uc800\uc7a5\ud588\uc2b5\ub2c8\ub2e4. \ube60\ub978 \uc124\uc815 \u2192 \ud3b8\uc9d1\uc5d0\uc11c\ub3c4 \ud0c0\uc77c\uc744 \ucd94\uac00\ud560 \uc218 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Connected"

    const-string v1, "\uc5f0\uacb0\ub428"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Connected \u00b7 "

    const-string v1, "\uc5f0\uacb0\ub428 \u00b7 "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Continue"

    const-string v1, "\uacc4\uc18d"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Controls"

    const-string v1, "\uc81c\uc5b4 \ud56d\ubaa9"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Copied"

    const-string v1, "\ubcf5\uc0ac\ub428"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Copy"

    const-string v1, "\ubcf5\uc0ac"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Could not back up HMA config"

    const-string v1, "HMA \uc124\uc815\uc744 \ubc31\uc5c5\ud558\uc9c0 \ubabb\ud588\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Could not complete: "

    const-string v1, "\uc644\ub8cc\ud558\uc9c0 \ubabb\ud568: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Could not load installed apps."

    const-string v1, "\uc124\uce58\ub41c \uc571\uc744 \ubd88\ub7ec\uc624\uc9c0 \ubabb\ud588\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Could not load unknown installed apps."

    const-string v1, "\ucd9c\ucc98 \ubd88\uba85 \uc124\uce58 \uc571\uc744 \ubd88\ub7ec\uc624\uc9c0 \ubabb\ud588\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Could not open file picker"

    const-string v1, "\ud30c\uc77c \uc120\ud0dd\uae30\ub97c \uc5f4\uc9c0 \ubabb\ud588\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Could not restore HMA config"

    const-string v1, "HMA \uc124\uc815\uc744 \ubcf5\uc6d0\ud558\uc9c0 \ubabb\ud588\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Could not save HMA settings"

    const-string v1, "HMA \uc124\uc815\uc744 \uc800\uc7a5\ud558\uc9c0 \ubabb\ud588\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Create backup"

    const-string v1, "\ubc31\uc5c5 \ub9cc\ub4e4\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Create backup for current ROM?"

    const-string v1, "\ud604\uc7ac \ub86c\uc758 \ubc31\uc5c5\uc744 \ub9cc\ub4e4\uae4c\uc694?"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Current: "

    const-string v1, "\ud604\uc7ac: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Custom ROM apps"

    const-string v1, "\ucee4\uc2a4\ud140 \ub86c \uc571"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Custom request"

    const-string v1, "\uc0ac\uc6a9\uc790 \uc9c0\uc815 \uc694\uccad"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Custom voltage request"

    const-string v1, "\uc0ac\uc6a9\uc790 \uc9c0\uc815 \uc804\uc555 \uc694\uccad"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Dark"

    const-string v1, "\ub2e4\ud06c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Detector / checker apps"

    const-string v1, "\ud0d0\uc9c0 / \uac80\uc0ac \uc571"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Developer options \u2014 hide ADB, developer and mock-location settings"

    const-string v1, "\uac1c\ubc1c\uc790 \uc635\uc158 \u2014 ADB, \uac1c\ubc1c\uc790, \ubaa8\uc758 \uc704\uce58 \uc124\uc815 \uc228\uae30\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Device status"

    const-string v1, "\uae30\uae30 \uc0c1\ud0dc"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Disable selected apps completely, not just their exemptions. Their services and features will stop. Calls, alarms, notifications, accounts and connectivity can fail. Protected recovery apps cannot be selected. Save and apply will ask before restarting after successful changes. Deselect or turn Battery Saving off to restore saved app states."

    const-string v1, "\uc608\uc678\ub9cc \uc5c6\uc560\ub294 \uac8c \uc544\ub2c8\ub77c \uc120\ud0dd\ud55c \uc571\uc744 \uc644\uc804\ud788 \uc0ac\uc6a9 \uc911\uc9c0\ud569\ub2c8\ub2e4. \ud574\ub2f9 \uc571\uc758 \uc11c\ube44\uc2a4\uc640 \uae30\ub2a5\uc774 \uba48\ucda5\ub2c8\ub2e4. \uc804\ud654, \uc54c\ub78c, \uc54c\ub9bc, \uacc4\uc815, \uc5f0\uacb0\uc774 \uc2e4\ud328\ud560 \uc218 \uc788\uc2b5\ub2c8\ub2e4. \ubcf5\uad6c\uc6a9\uc73c\ub85c \ubcf4\ud638\ub41c \uc571\uc740 \uc120\ud0dd\ud560 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4. \ubcc0\uacbd\uc774 \uc131\uacf5\ud558\uba74 \uc800\uc7a5 \ubc0f \uc801\uc6a9\uc5d0\uc11c \ub2e4\uc2dc \uc2dc\uc791\ud558\uae30 \uc804\uc5d0 \ubb3b\uc2b5\ub2c8\ub2e4. \uc120\ud0dd\uc744 \ud574\uc81c\ud558\uac70\ub098 \ubc30\ud130\ub9ac \uc808\uc57d\uc744 \ub044\uba74 \uc800\uc7a5\ub41c \uc571 \uc0c1\ud0dc\ub85c \ub3cc\uc544\uac11\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Display modes unavailable; refresh-rate control disabled"

    const-string v1, "\ub514\uc2a4\ud50c\ub808\uc774 \ubaa8\ub4dc\ub97c \uc4f8 \uc218 \uc5c6\uc5b4 \uc8fc\uc0ac\uc728 \uc81c\uc5b4\ub97c \uaed0\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Do Not Disturb"

    const-string v1, "\ubc29\ud574 \uae08\uc9c0"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Download latest OTA"

    const-string v1, "\ucd5c\uc2e0 OTA \ub2e4\uc6b4\ub85c\ub4dc"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Download the latest OTA from the folder, then return here and select its ZIP."

    const-string v1, "\ud3f4\ub354\uc5d0\uc11c \ucd5c\uc2e0 OTA\ub97c \ub2e4\uc6b4\ub85c\ub4dc\ud55c \ub4a4 \uc5ec\uae30\ub85c \ub3cc\uc544\uc640 ZIP\uc744 \uc120\ud0dd\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Doze exemptions"

    const-string v1, "Doze \uc608\uc678"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Draft level added"

    const-string v1, "\ucd08\uc548 \ub2e8\uacc4 \ucd94\uac00\ub428"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Edit GPU table"

    const-string v1, "GPU \ud14c\uc774\ube14 \ud3b8\uc9d1"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Enable All"

    const-string v1, "\ubaa8\ub450 \ucf1c\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Enable Battery Saving"

    const-string v1, "\ubc30\ud130\ub9ac \uc808\uc57d \ucf1c\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Encryption Spoof"

    const-string v1, "\uc554\ud638\ud654 \uc704\uc7a5"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Exempted (5)"

    const-string v1, "\uc608\uc678 (5)"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private static fill1(Ljava/util/HashMap;)V
    .locals 2

    const-string v0, "Exempted App"

    const-string v1, "\uc608\uc678 \uc571"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Expected "

    const-string v1, "\ud544\uc694\ud55c \uac12 "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Expected whole number: "

    const-string v1, "\uc815\uc218\uac00 \ud544\uc694\ud568: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Experimental settings"

    const-string v1, "\uc2e4\ud5d8\uc801 \uc124\uc815"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Experimental. These choices remove supplementary groups from selected apps at their next process start. Network or storage access may stop working and apps may crash. Restart selected apps after changing this setting."

    const-string v1, "\uc2e4\ud5d8\uc801 \uae30\ub2a5\uc785\ub2c8\ub2e4. \uc120\ud0dd\ud55c \uc571\uc774 \ub2e4\uc74c\uc5d0 \ud504\ub85c\uc138\uc2a4\ub97c \uc2dc\uc791\ud560 \ub54c \ubcf4\uc870 \uadf8\ub8f9\uc744 \uc81c\uac70\ud569\ub2c8\ub2e4. \ub124\ud2b8\uc6cc\ud06c\ub098 \uc800\uc7a5\uc18c \uc811\uadfc\uc774 \uc548 \ub418\uac70\ub098 \uc571\uc774 \uc885\ub8cc\ub420 \uc218 \uc788\uc2b5\ub2c8\ub2e4. \uc774 \uc124\uc815\uc744 \ubc14\uafbc \ub4a4\uc5d0\ub294 \uc120\ud0dd\ud55c \uc571\uc744 \ub2e4\uc2dc \uc2dc\uc791\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Fast charging"

    const-string v1, "\uace0\uc18d \ucda9\uc804"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "File picker unavailable"

    const-string v1, "\ud30c\uc77c \uc120\ud0dd\uae30\ub97c \uc0ac\uc6a9\ud560 \uc218 \uc5c6\uc74c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Final GPU row bypasses the driver bus clamp: bus maximum must be 0\u20139 (got "

    const-string v1, "\ub9c8\uc9c0\ub9c9 GPU \ud589\uc740 \ub4dc\ub77c\uc774\ubc84 \ubc84\uc2a4 \uc81c\ud55c\uc744 \uac70\uce58\uc9c0 \uc54a\uc2b5\ub2c8\ub2e4: \ubc84\uc2a4 \ucd5c\ub300\uac12\uc740 0\u20139\uc5ec\uc57c \ud569\ub2c8\ub2e4 (\uc785\ub825\uac12 "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Flashlight"

    const-string v1, "\uc190\uc804\ub4f1"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Frequent (30)"

    const-string v1, "\uc790\uc8fc \uc0ac\uc6a9 (30)"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Full background restrictions: "

    const-string v1, "\ubc31\uadf8\ub77c\uc6b4\ub4dc \uc804\uccb4 \uc81c\ud55c: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Full restrictions: choose Play Store, Play services, Galaxy Store or other apps. Applies restricted standby, background execution limits, metered background data blocking and removal of user Doze exemptions. Automatic account sync and Data Saver are separate controls above. Unmetered Wi-Fi is not fully blocked."

    const-string v1, "\uc804\uccb4 \uc81c\ud55c: Play \uc2a4\ud1a0\uc5b4, Play \uc11c\ube44\uc2a4, Galaxy Store \ub4f1\uc758 \uc571\uc744 \uace0\ub974\uc138\uc694. \ub300\uae30 \uc81c\ud55c, \ubc31\uadf8\ub77c\uc6b4\ub4dc \uc2e4\ud589 \uc81c\ud55c, \uc885\ub7c9\uc81c \ubc31\uadf8\ub77c\uc6b4\ub4dc \ub370\uc774\ud130 \ucc28\ub2e8, \uc0ac\uc6a9\uc790 Doze \uc608\uc678 \uc0ad\uc81c\uac00 \uc801\uc6a9\ub429\ub2c8\ub2e4. \uacc4\uc815 \uc790\ub3d9 \ub3d9\uae30\ud654\uc640 \ub370\uc774\ud130 \uc808\uc57d \ubaa8\ub4dc\ub294 \uc704\uc5d0 \uc788\ub294 \ubcc4\ub3c4 \ud56d\ubaa9\uc785\ub2c8\ub2e4. \ube44\uc885\ub7c9\uc81c Wi-Fi\ub294 \uc644\uc804\ud788 \ucc28\ub2e8\ub418\uc9c0 \uc54a\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "GPU frequency (MHz)"

    const-string v1, "GPU \uc8fc\ud30c\uc218 (MHz)"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "GPU frequency and voltage tuning for S23 Ultra."

    const-string v1, "S23 \uc6b8\ud2b8\ub77c\uc6a9 GPU \uc8fc\ud30c\uc218\u00b7\uc804\uc555 \ud29c\ub2dd"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "GPU image"

    const-string v1, "GPU \uc774\ubbf8\uc9c0"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "GPU operation failed"

    const-string v1, "GPU \uc791\uc5c5 \uc2e4\ud328"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "GPU tables"

    const-string v1, "GPU \ud14c\uc774\ube14"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "GPU tuning"

    const-string v1, "GPU \ud29c\ub2dd"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "HMA config backed up"

    const-string v1, "HMA \uc124\uc815\uc744 \ubc31\uc5c5\ud588\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "HMA config restored"

    const-string v1, "HMA \uc124\uc815\uc744 \ubcf5\uc6d0\ud588\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "INET (3003) \u2014 removes network access; apps may crash"

    const-string v1, "INET (3003) \u2014 \ub124\ud2b8\uc6cc\ud06c \uc811\uadfc\uc744 \ub9c9\uc74c; \uc571\uc774 \uc885\ub8cc\ub420 \uc218 \uc788\uc74c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Icon"

    const-string v1, "\uc544\uc774\ucf58"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Icon: "

    const-string v1, "\uc544\uc774\ucf58: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "If Android cannot start"

    const-string v1, "Android\uac00 \uc2dc\uc791\ub418\uc9c0 \uc54a\uc744 \ub54c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Index from 0 to "

    const-string v1, "\uc778\ub371\uc2a4 \ubc94\uc704: 0 ~ "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Initial power level"

    const-string v1, "\ucd08\uae30 \uc804\ub825 \ub2e8\uacc4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Input method \u2014 report Gboard and Google TTS; filter keyboard lists"

    const-string v1, "\uc785\ub825 \ubc29\ubc95 \u2014 Gboard\uc640 Google TTS\ub85c \ubcf4\uace0\ud558\uace0 \ud0a4\ubcf4\ub4dc \ubaa9\ub85d \ud544\ud130\ub9c1"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Inspired by libxzr/KonaBess. Both Samsung GPU tables, within the inspected FDT space. Nothing applies or reboots automatically."

    const-string v1, "libxzr/KonaBess\ub97c \ucc38\uace0\ud588\uc2b5\ub2c8\ub2e4. \ud655\uc778\ub41c FDT \uacf5\uac04 \uc548\uc5d0\uc11c \uc0bc\uc131 GPU \ud14c\uc774\ube14 \ub450 \uac1c\ub97c \ubaa8\ub450 \ub2e4\ub8f9\ub2c8\ub2e4. \uc790\ub3d9\uc73c\ub85c \uc801\uc6a9\ub418\uac70\ub098 \uc7ac\ubd80\ud305\ub418\ub294 \uac83\uc740 \uc5c6\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Install"

    const-string v1, "\uc124\uce58"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Install OTA update?"

    const-string v1, "OTA \uc5c5\ub370\uc774\ud2b8\ub97c \uc124\uce58\ud560\uae4c\uc694?"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Install and reboot"

    const-string v1, "\uc124\uce58 \ud6c4 \uc7ac\ubd80\ud305"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Installed software"

    const-string v1, "\uc124\uce58\ub41c \uc18c\ud504\ud2b8\uc6e8\uc5b4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Invalid GPU frequency, RPMh request, bus ordering or ACD cell at level "

    const-string v1, "GPU \uc8fc\ud30c\uc218, RPMh \uc694\uccad, \ubc84\uc2a4 \uc21c\uc11c \ub610\ub294 ACD \uc140\uc774 \uc798\ubabb\ub41c \ub2e8\uacc4: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Invalid profile text: "

    const-string v1, "\uc798\ubabb\ub41c \ud504\ub85c\ud544 \ub0b4\uc6a9: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Invalid value for "

    const-string v1, "\uc798\ubabb\ub41c \uac12: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Keep the rollback ZIP and recovery available. Only reboot after Apply or Restore reports success."

    const-string v1, "\ub864\ubc31 ZIP\uacfc \ub9ac\ucee4\ubc84\ub9ac\ub97c \uc900\ube44\ud574 \ub450\uc138\uc694. \uc801\uc6a9\uc774\ub098 \ubcf5\uc6d0\uc774 \uc131\uacf5\ud588\ub2e4\uace0 \ub098\uc628 \ub4a4\uc5d0\ub9cc \uc7ac\ubd80\ud305\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Kernel controls unavailable: "

    const-string v1, "\ucee4\ub110 \uc81c\uc5b4\ub97c \uc0ac\uc6a9\ud560 \uc218 \uc5c6\uc74c: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "LSPosed / Xposed modules"

    const-string v1, "LSPosed / Xposed \ubaa8\ub4c8"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Last installation: "

    const-string v1, "\ub9c8\uc9c0\ub9c9 \uc124\uce58: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Level "

    const-string v1, "\ub2e8\uacc4 "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Light"

    const-string v1, "\ub77c\uc774\ud2b8"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Load imported tuning profile?"

    const-string v1, "\uac00\uc838\uc628 \ud29c\ub2dd \ud504\ub85c\ud544\uc744 \ubd88\ub7ec\uc62c\uae4c\uc694?"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Load profile"

    const-string v1, "\ud504\ub85c\ud544 \ubd88\ub7ec\uc624\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Load values"

    const-string v1, "\uac12 \ubd88\ub7ec\uc624\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Loading apps\u2026"

    const-string v1, "\uc571 \ubd88\ub7ec\uc624\ub294 \uc911\u2026"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Location in use"

    const-string v1, "\uc704\uce58 \uc0ac\uc6a9 \uc911"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Low battery"

    const-string v1, "\ubc30\ud130\ub9ac \ubd80\uc871"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "MEDIA_RW (1023) \u2014 media write access"

    const-string v1, "MEDIA_RW (1023) \u2014 \ubbf8\ub514\uc5b4 \uc4f0\uae30 \uad8c\ud55c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Microphone in use"

    const-string v1, "\ub9c8\uc774\ud06c \uc0ac\uc6a9 \uc911"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Missing or malformed "

    const-string v1, "\uc5c6\uac70\ub098 \ud615\uc2dd\uc774 \uc798\ubabb\ub428: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Missing profile field: "

    const-string v1, "\ud504\ub85c\ud544 \ud56d\ubaa9 \uc5c6\uc74c: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "My GPU profile"

    const-string v1, "\ub0b4 GPU \ud504\ub85c\ud544"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "NOSLEN disables Wi-Fi runtime suspend and PCIe link power saving, disables Wi-Fi wakeup, sets swappiness to 60 and cached processes to 32, and restricts three Samsung apps. It may increase drain or delay background communication. Unsupported controls will be reported."

    const-string v1, "NOSLEN\uc740 Wi-Fi \ub7f0\ud0c0\uc784 \uc808\uc804\uacfc PCIe \ub9c1\ud06c \uc808\uc804\uc744 \ub044\uace0, Wi-Fi \uae68\uc6b0\uae30\ub97c \ub044\uace0, swappiness\ub97c 60, \uce90\uc2dc \ud504\ub85c\uc138\uc2a4\ub97c 32\ub85c \ub9de\ucd94\uace0, \uc0bc\uc131 \uc571 3\uac1c\ub97c \uc81c\ud55c\ud569\ub2c8\ub2e4. \ubc30\ud130\ub9ac \uc18c\ubaa8\uac00 \ub298\uac70\ub098 \ubc31\uadf8\ub77c\uc6b4\ub4dc \ud1b5\uc2e0\uc774 \ub2a6\uc5b4\uc9c8 \uc218 \uc788\uc2b5\ub2c8\ub2e4. \uc9c0\uc6d0\ub418\uc9c0 \uc54a\ub294 \ud56d\ubaa9\uc740 \ub530\ub85c \uc54c\ub824\uc90d\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "NOSLEN profile"

    const-string v1, "NOSLEN \ud504\ub85c\ud544"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Navigate up"

    const-string v1, "\uc704\ub85c \uc774\ub3d9"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Never (50)"

    const-string v1, "\uc0ac\uc6a9 \uc548 \ud568 (50)"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "No app available to open this link."

    const-string v1, "\uc774 \ub9c1\ud06c\ub97c \uc5f4 \uc218 \uc788\ub294 \uc571\uc774 \uc5c6\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "No app can open the download folder. Install a browser, or select an OTA ZIP downloaded elsewhere."

    const-string v1, "\ub2e4\uc6b4\ub85c\ub4dc \ud3f4\ub354\ub97c \uc5f4 \uc218 \uc788\ub294 \uc571\uc774 \uc5c6\uc2b5\ub2c8\ub2e4. \ube0c\ub77c\uc6b0\uc800\ub97c \uc124\uce58\ud558\uac70\ub098 \ub2e4\ub978 \uacf3\uc5d0\uc11c \ubc1b\uc740 OTA ZIP\uc744 \uc120\ud0dd\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "No apps selected"

    const-string v1, "\uc120\ud0dd\ud55c \uc571 \uc5c6\uc74c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "No apps selected for disabling"

    const-string v1, "\uc0ac\uc6a9 \uc911\uc9c0\ud560 \uc571\uc744 \uc120\ud0dd\ud558\uc9c0 \uc54a\uc74c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "No saved profile"

    const-string v1, "\uc800\uc7a5\ub41c \ud504\ub85c\ud544 \uc5c6\uc74c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Not configured"

    const-string v1, "\uc124\uc815 \uc548 \ub428"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "OTA Update"

    const-string v1, "OTA \uc5c5\ub370\uc774\ud2b8"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "OTA verified. Ready to install."

    const-string v1, "OTA \uac80\uc99d \uc644\ub8cc. \uc124\uce58\ud560 \uc218 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Off"

    const-string v1, "\uaebc\uc9d0"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "One tap runs the selected action. Changes take effect after Save."

    const-string v1, "\ud55c \ubc88 \ub204\ub974\uba74 \uc120\ud0dd\ud55c \ub3d9\uc791\uc744 \uc2e4\ud589\ud569\ub2c8\ub2e4. \ubcc0\uacbd \uc0ac\ud56d\uc740 \uc800\uc7a5 \ud6c4 \uc801\uc6a9\ub429\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Only select apps whose background work you can limit. Restricting messaging, alarms, VPN, wearables or Samsung feature providers can break expected behavior. No apps are selected by Balanced or Efficiency."

    const-string v1, "\ubc31\uadf8\ub77c\uc6b4\ub4dc \uc791\uc5c5\uc744 \uc81c\ud55c\ud574\ub3c4 \uad1c\ucc2e\uc740 \uc571\ub9cc \uace0\ub974\uc138\uc694. \uba54\uc2e0\uc800, \uc54c\ub78c, VPN, \uc6e8\uc5b4\ub7ec\ube14, \uc0bc\uc131 \uae30\ub2a5 \uc81c\uacf5 \uc571\uc744 \uc81c\ud55c\ud558\uba74 \uc815\uc0c1 \ub3d9\uc791\uc774 \uae68\uc9c8 \uc218 \uc788\uc2b5\ub2c8\ub2e4. Balanced\uc640 Efficiency\ub294 \uc571\uc744 \uc120\ud0dd\ud558\uc9c0 \uc54a\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Open the download folder in your browser"

    const-string v1, "\ube0c\ub77c\uc6b0\uc800\uc5d0\uc11c \ub2e4\uc6b4\ub85c\ub4dc \ud3f4\ub354 \uc5f4\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Operation failed: "

    const-string v1, "\uc791\uc5c5 \uc2e4\ud328: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Outside stock RPMh requests. "

    const-string v1, "\uc21c\uc815 RPMh \uc694\uccad \ubc94\uc704\ub97c \ubc97\uc5b4\ub0ac\uc2b5\ub2c8\ub2e4. "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Outside stock frequency table. "

    const-string v1, "\uc21c\uc815 \uc8fc\ud30c\uc218 \ud14c\uc774\ube14\uc744 \ubc97\uc5b4\ub0ac\uc2b5\ub2c8\ub2e4. "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "PACKAGE_INFO (1032) \u2014 package details"

    const-string v1, "PACKAGE_INFO (1032) \u2014 \ud328\ud0a4\uc9c0 \uc138\ubd80 \uc815\ubcf4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Package checksum failed: "

    const-string v1, "\ud328\ud0a4\uc9c0 \uccb4\ud06c\uc12c \uc2e4\ud328: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Pinned Samsung S918BXXUAZZI8 table defaults"

    const-string v1, "\uace0\uc815\ub41c \uc0bc\uc131 S918BXXUAZZI8 \ud14c\uc774\ube14 \uae30\ubcf8\uac12"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Power level "

    const-string v1, "\uc804\ub825 \ub2e8\uacc4 "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Predefined action"

    const-string v1, "\uae30\ubcf8 \uc81c\uacf5 \ub3d9\uc791"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Preset: "

    const-string v1, "\ud504\ub9ac\uc14b: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Private DNS provider hostname"

    const-string v1, "\uac1c\uc778 DNS \uc81c\uacf5\uc790 \ud638\uc2a4\ud2b8 \uc774\ub984"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Profile backup"

    const-string v1, "\ud504\ub85c\ud544 \ubc31\uc5c5"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Profile operation failed"

    const-string v1, "\ud504\ub85c\ud544 \uc791\uc5c5 \uc2e4\ud328"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Profile operation failed: "

    const-string v1, "\ud504\ub85c\ud544 \uc791\uc5c5 \uc2e4\ud328: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Quick Tiles"

    const-string v1, "\ube60\ub978 \uc124\uc815 \ud0c0\uc77c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "RAW EXPERIMENTAL"

    const-string v1, "RAW \uc2e4\ud5d8\uc801"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Rare"

    const-string v1, "\ub4dc\ubb3c\uac8c \uc0ac\uc6a9"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Rare (40)"

    const-string v1, "\ub4dc\ubb3c\uac8c \uc0ac\uc6a9 (40)"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Raw RPMh request, 1\u2013480. This is not millivolts or a hardware-supported range. Request 1 and values outside stock are experimental."

    const-string v1, "RPMh \uc6d0\uc2dc \uc694\uccad \uac12, 1\u2013480. \ubc00\ub9ac\ubcfc\ud2b8\ub098 \ud558\ub4dc\uc6e8\uc5b4 \uc9c0\uc6d0 \ubc94\uc704\uac00 \uc544\ub2d9\ub2c8\ub2e4. \uc694\uccad \uac12 1\uacfc \uc21c\uc815 \ubc94\uc704\ub97c \ubc97\uc5b4\ub09c \uac12\uc740 \uc2e4\ud5d8\uc801\uc785\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Readback differs: requested "

    const-string v1, "\ub2e4\uc2dc \uc77d\uc740 \uac12\uc774 \ub2e4\ub984: \uc694\uccad "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Reading OTA: "

    const-string v1, "OTA \uc77d\ub294 \uc911: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Reboot"

    const-string v1, "\uc7ac\ubd80\ud305"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Reboot device?"

    const-string v1, "\uae30\uae30\ub97c \uc7ac\ubd80\ud305\ud560\uae4c\uc694?"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Rebooting into OrangeFox\u2026"

    const-string v1, "OrangeFox\ub85c \uc7ac\ubd80\ud305\ud558\ub294 \uc911\u2026"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Recovery rollback"

    const-string v1, "\ub9ac\ucee4\ubc84\ub9ac \ub864\ubc31"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Red values are outside stock or change bus/ACD behavior. They may map to different corners, freeze the GPU or prevent booting. Request 1 is experimental and is not 1 mV."

    const-string v1, "\ube68\uac04 \uac12\uc740 \uc21c\uc815 \ubc94\uc704\ub97c \ubc97\uc5b4\ub0ac\uac70\ub098 \ubc84\uc2a4/ACD \ub3d9\uc791\uc744 \ubc14\uafc9\ub2c8\ub2e4. \ub2e4\ub978 \ucf54\ub108\ub85c \ub300\uc751\ub418\uac70\ub098 GPU\uac00 \uba48\ucd94\uac70\ub098 \ubd80\ud305\uc774 \uc548 \ub420 \uc218 \uc788\uc2b5\ub2c8\ub2e4. \uc694\uccad \uac12 1\uc740 \uc2e4\ud5d8\uc801\uc774\uba70 1 mV\uac00 \uc544\ub2d9\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Refresh device status"

    const-string v1, "\uae30\uae30 \uc0c1\ud0dc \uc0c8\ub85c \uace0\uce68"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Refresh image and compatibility"

    const-string v1, "\uc774\ubbf8\uc9c0\uc640 \ud638\ud658\uc131 \uc0c8\ub85c \uace0\uce68"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Remove"

    const-string v1, "\uc0ad\uc81c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Remove only unnecessary user-added exemptions. Essential messaging and service dependencies should retain them. System exemptions may be protected by Android."

    const-string v1, "\uc0ac\uc6a9\uc790\uac00 \ucd94\uac00\ud55c \ubd88\ud544\uc694\ud55c \uc608\uc678\ub9cc \uc0ad\uc81c\ud558\uc138\uc694. \uaf2d \ud544\uc694\ud55c \uba54\uc2e0\uc800\uc640 \uc11c\ube44\uc2a4 \uc758\uc874 \uc571\uc740 \uc720\uc9c0\ud574\uc57c \ud569\ub2c8\ub2e4. \uc2dc\uc2a4\ud15c \uc608\uc678\ub294 Android\uac00 \ubcf4\ud638\ud560 \uc218 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Remove power level "

    const-string v1, "\uc804\ub825 \ub2e8\uacc4 \uc0ad\uc81c "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Replace saved profile values?"

    const-string v1, "\uc800\uc7a5\ub41c \ud504\ub85c\ud544 \uac12\uc744 \ubc14\uafc0\uae4c\uc694?"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Reply"

    const-string v1, "\ub2f5\uc7a5"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Reply to "

    const-string v1, "\ub2f5\uc7a5: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Reset"

    const-string v1, "\ucd08\uae30\ud654"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Reset this slot"

    const-string v1, "\uc774 \uc2ac\ub86f \ucd08\uae30\ud654"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restart backup"

    const-string v1, "\ubc31\uc5c5 \ub2e4\uc2dc \uc2dc\uc791"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restart backup for this ROM?"

    const-string v1, "\uc774 \ub86c\uc758 \ubc31\uc5c5\uc744 \ub2e4\uc2dc \uc2dc\uc791\ud560\uae4c\uc694?"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restart into OrangeFox to install the verified update"

    const-string v1, "\uac80\uc99d\ub41c \uc5c5\ub370\uc774\ud2b8\ub97c \uc124\uce58\ud558\ub824\uba74 OrangeFox\ub85c \ub2e4\uc2dc \uc2dc\uc791\ud558\uc138\uc694"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restart protected apps so restored package visibility and process permission changes apply."

    const-string v1, "\ubcf5\uc6d0\ub41c \ud328\ud0a4\uc9c0 \ud45c\uc2dc \uc5ec\ubd80\uc640 \ud504\ub85c\uc138\uc2a4 \uad8c\ud55c \ubcc0\uacbd\uc744 \uc801\uc6a9\ud558\ub824\uba74 \ubcf4\ud638 \ub300\uc0c1 \uc571\uc744 \ub2e4\uc2dc \uc2dc\uc791\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restore"

    const-string v1, "\ubcf5\uc6d0"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restore and restart"

    const-string v1, "\ubcf5\uc6d0 \ud6c4 \ub2e4\uc2dc \uc2dc\uc791"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restore deferred for "

    const-string v1, "\ubcf5\uc6d0 \ubcf4\ub958: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restore failed for "

    const-string v1, "\ubcf5\uc6d0 \uc2e4\ud328: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restore original GPU image?"

    const-string v1, "\uc6d0\ub798 GPU \uc774\ubbf8\uc9c0\ub85c \ubcf5\uc6d0\ud560\uae4c\uc694?"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restore profile"

    const-string v1, "\ud504\ub85c\ud544 \ubcf5\uc6d0"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restore profile?"

    const-string v1, "\ud504\ub85c\ud544\uc744 \ubcf5\uc6d0\ud560\uae4c\uc694?"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restrict Zygote permissions"

    const-string v1, "Zygote \uad8c\ud55c \uc81c\ud55c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restricted"

    const-string v1, "\uc81c\ud55c\ub428"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restricted (45)"

    const-string v1, "\uc81c\ud55c\ub428 (45)"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Review its frequency, RPMh, bus and ACD values. These draft values are not a stability recommendation."

    const-string v1, "\uc8fc\ud30c\uc218, RPMh, \ubc84\uc2a4, ACD \uac12\uc744 \ud655\uc778\ud558\uc138\uc694. \uc774 \ucd08\uc548 \uac12\uc740 \uc548\uc815\uc131\uc744 \uad8c\uc7a5\ud558\ub294 \uac12\uc774 \uc544\ub2d9\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Ring"

    const-string v1, "\uc18c\ub9ac"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Rollback export failed"

    const-string v1, "\ub864\ubc31 \ub0b4\ubcf4\ub0b4\uae30 \uc2e4\ud328"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private static fill2(Ljava/util/HashMap;)V
    .locals 2

    const-string v0, "Rollback export failed: "

    const-string v1, "\ub864\ubc31 \ub0b4\ubcf4\ub0b4\uae30 \uc2e4\ud328: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Rollback unavailable"

    const-string v1, "\ub864\ubc31\uc744 \uc0ac\uc6a9\ud560 \uc218 \uc5c6\uc74c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Root managers and rooted apps"

    const-string v1, "\ub8e8\ud2b8 \uad00\ub9ac\uc790 \ubc0f \ub8e8\ud305 \uc571"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "SDCARD_RW (1015) \u2014 media write access"

    const-string v1, "SDCARD_RW (1015) \u2014 \ubbf8\ub514\uc5b4 \uc4f0\uae30 \uad8c\ud55c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "SHARED_USER (9997) \u2014 may block all shared storage access"

    const-string v1, "SHARED_USER (9997) \u2014 \uacf5\uc720 \uc800\uc7a5\uc18c \uc811\uadfc\uc774 \ubaa8\ub450 \ub9c9\ud790 \uc218 \uc788\uc74c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Samsung Galaxy Store"

    const-string v1, "\uc0bc\uc131 Galaxy Store"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Save"

    const-string v1, "\uc800\uc7a5"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Save and add to Quick Settings"

    const-string v1, "\uc800\uc7a5\ud558\uace0 \ube60\ub978 \uc124\uc815\uc5d0 \ucd94\uac00"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Save and apply"

    const-string v1, "\uc800\uc7a5 \ubc0f \uc801\uc6a9"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Save selection"

    const-string v1, "\uc120\ud0dd \uc800\uc7a5"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Save, apply & restart"

    const-string v1, "\uc800\uc7a5, \uc801\uc6a9 \ud6c4 \ub2e4\uc2dc \uc2dc\uc791"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Save, apply and restart?"

    const-string v1, "\uc800\uc7a5\ud558\uace0 \uc801\uc6a9\ud55c \ub4a4 \ub2e4\uc2dc \uc2dc\uc791\ud560\uae4c\uc694?"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Saved profile unavailable"

    const-string v1, "\uc800\uc7a5\ub41c \ud504\ub85c\ud544\uc744 \uc0ac\uc6a9\ud560 \uc218 \uc5c6\uc74c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Saved value "

    const-string v1, "\uc800\uc7a5\ub41c \uac12 "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Saving verified OTA"

    const-string v1, "\uac80\uc99d\ub41c OTA \uc800\uc7a5 \uc911"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Screen recording"

    const-string v1, "\ud654\uba74 \ub179\ud654"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Search app name or package"

    const-string v1, "\uc571 \uc774\ub984 \ub610\ub294 \ud328\ud0a4\uc9c0 \uac80\uc0c9"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Search apps"

    const-string v1, "\uc571 \uac80\uc0c9"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Select a local OTA ZIP"

    const-string v1, "\uae30\uae30\uc5d0 \uc788\ub294 OTA ZIP \uc120\ud0dd"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Select an OTA ZIP to check for an update."

    const-string v1, "\uc5c5\ub370\uc774\ud2b8\ub97c \ud655\uc778\ud560 OTA ZIP\uc744 \uc120\ud0dd\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Select the downloaded OTA ZIP first."

    const-string v1, "\uba3c\uc800 \ub2e4\uc6b4\ub85c\ub4dc\ud55c OTA ZIP\uc744 \uc120\ud0dd\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Selected Exempted Apps will be disabled completely while Battery Saving is enabled. Apps removed from the selection, or all saved apps when Battery Saving is turned off, will return to their original enabled states. Calls, alarms, notifications and connectivity can stop working. Save your work. After successful app-state changes this phone will restart automatically. If changes fail, it will stay on so you can review the errors. Disabling takes effect immediately; the restart completes this workflow."

    const-string v1, "\ubc30\ud130\ub9ac \uc808\uc57d\uc774 \ucf1c\uc838 \uc788\ub294 \ub3d9\uc548 \uc120\ud0dd\ud55c \uc608\uc678 \uc571\uc740 \uc644\uc804\ud788 \uc0ac\uc6a9 \uc911\uc9c0\ub429\ub2c8\ub2e4. \uc120\ud0dd\uc5d0\uc11c \ube80 \uc571, \ub610\ub294 \ubc30\ud130\ub9ac \uc808\uc57d\uc744 \ub04c \ub54c \uc800\uc7a5\ub41c \ubaa8\ub4e0 \uc571\uc740 \uc6d0\ub798 \uc0ac\uc6a9 \uc0c1\ud0dc\ub85c \ub3cc\uc544\uac11\ub2c8\ub2e4. \uc804\ud654, \uc54c\ub78c, \uc54c\ub9bc, \uc5f0\uacb0\uc774 \uc791\ub3d9\ud558\uc9c0 \uc54a\uc744 \uc218 \uc788\uc2b5\ub2c8\ub2e4. \ud558\ub358 \uc791\uc5c5\uc744 \uc800\uc7a5\ud558\uc138\uc694. \uc571 \uc0c1\ud0dc \ubcc0\uacbd\uc774 \uc131\uacf5\ud558\uba74 \ud734\ub300\uc804\ud654\uac00 \uc790\ub3d9\uc73c\ub85c \ub2e4\uc2dc \uc2dc\uc791\ub429\ub2c8\ub2e4. \ubcc0\uacbd\uc5d0 \uc2e4\ud328\ud558\uba74 \uc624\ub958\ub97c \ud655\uc778\ud560 \uc218 \uc788\ub3c4\ub85d \ucf1c\uc9c4 \uc0c1\ud0dc\ub85c \ub461\ub2c8\ub2e4. \uc0ac\uc6a9 \uc911\uc9c0\ub294 \ubc14\ub85c \uc801\uc6a9\ub418\uba70, \ub2e4\uc2dc \uc2dc\uc791\ud558\uba74 \uc774 \uacfc\uc815\uc774 \ub9c8\ubb34\ub9ac\ub429\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Selected app restrictions can interrupt notifications, alarms, calls, account services and background work. Wi-Fi radio off disconnects all Wi-Fi; Wi-Fi Calling off can prevent calls where cellular coverage is poor. Only the selected controls and apps will change. Disable Battery Saving to restore saved settings."

    const-string v1, "\uc120\ud0dd\ud55c \uc571 \uc81c\ud55c\uc740 \uc54c\ub9bc, \uc54c\ub78c, \uc804\ud654, \uacc4\uc815 \uc11c\ube44\uc2a4, \ubc31\uadf8\ub77c\uc6b4\ub4dc \uc791\uc5c5\uc744 \ubc29\ud574\ud560 \uc218 \uc788\uc2b5\ub2c8\ub2e4. Wi-Fi \ubb34\uc120\uc744 \ub044\uba74 \ubaa8\ub4e0 Wi-Fi \uc5f0\uacb0\uc774 \ub04a\uae30\uace0, Wi-Fi \ud1b5\ud654\ub97c \ub044\uba74 \uc140\ub8f0\ub7ec \uc218\uc2e0\uc774 \uc57d\ud55c \uacf3\uc5d0\uc11c \uc804\ud654\uac00 \uc548 \ub420 \uc218 \uc788\uc2b5\ub2c8\ub2e4. \uc120\ud0dd\ud55c \ud56d\ubaa9\uacfc \uc571\ub9cc \ubc14\ub01d\ub2c8\ub2e4. \ubc30\ud130\ub9ac \uc808\uc57d\uc744 \ub044\uba74 \uc800\uc7a5\ub41c \uc124\uc815\uc73c\ub85c \ub3cc\uc544\uac11\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Send"

    const-string v1, "\ubcf4\ub0b4\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Setting changed"

    const-string v1, "\uc124\uc815 \ubcc0\uacbd"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Sharing screen"

    const-string v1, "\ud654\uba74 \uacf5\uc720 \uc911"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Shizuku / Dhizuku apps"

    const-string v1, "Shizuku / Dhizuku \uc571"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Shortcut access is unavailable for this app."

    const-string v1, "\uc774 \uc571\uc758 \ubc14\ub85c\uac00\uae30\ub97c \uc0ac\uc6a9\ud560 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Silent"

    const-string v1, "\ubb34\uc74c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Sound mode"

    const-string v1, "\uc18c\ub9ac \ubaa8\ub4dc"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Spoof installation source"

    const-string v1, "\uc124\uce58 \ucd9c\ucc98 \uc704\uc7a5"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Standby bucket readback differs: requested "

    const-string v1, "\ub300\uae30 \ubc84\ud0b7 \uac12\uc774 \ub2e4\ub984: \uc694\uccad "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Stingy: aggressive saving"

    const-string v1, "Stingy: \uac15\ub825 \uc808\uc57d"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Stock comparison unavailable. "

    const-string v1, "\uc21c\uc815 \uac12\uacfc \ube44\uad50\ud560 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4. "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Stop"

    const-string v1, "\uc911\uc9c0"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Super fast charging"

    const-string v1, "\ucd08\uace0\uc18d \ucda9\uc804"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Suspicious apps"

    const-string v1, "\uc758\uc2ec \uc571"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "SystemUI restart was not permitted"

    const-string v1, "SystemUI \ub2e4\uc2dc \uc2dc\uc791\uc774 \ud5c8\uc6a9\ub418\uc9c0 \uc54a\uc558\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Table 0 \u00b7 SKU-specific"

    const-string v1, "\ud14c\uc774\ube14 0 \u00b7 SKU \uc804\uc6a9"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Table 1 \u00b7 fallback"

    const-string v1, "\ud14c\uc774\ube14 1 \u00b7 \ub300\uccb4\uc6a9"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Targeted app restrictions"

    const-string v1, "\ub300\uc0c1 \uc571 \uc81c\ud55c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "The current HMA configuration was exported as an HMA-OSS style JSON file."

    const-string v1, "\ud604\uc7ac HMA \uc124\uc815\uc744 HMA-OSS \ud615\uc2dd\uc758 JSON \ud30c\uc77c\ub85c \ub0b4\ubcf4\ub0c8\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "The current image differs from the saved original. Copy and verify the old rollback in protected /data storage before freeing its /cache space. Then back up this ROM\'s clean vendor_boot and save the new rollback ZIP to PC or USB. Your tuning profile stays saved. This does not flash either image."

    const-string v1, "\ud604\uc7ac \uc774\ubbf8\uc9c0\uac00 \uc800\uc7a5\ub41c \uc6d0\ubcf8\uacfc \ub2e4\ub985\ub2c8\ub2e4. /cache \uacf5\uac04\uc744 \ube44\uc6b0\uae30 \uc804\uc5d0 \uc774\uc804 \ub864\ubc31\uc744 \ubcf4\ud638\ub41c /data \uc800\uc7a5\uc18c\uc5d0 \ubcf5\uc0ac\ud574 \uac80\uc99d\ud558\uc138\uc694. \uadf8\ub2e4\uc74c \uc774 \ub86c\uc758 \uae68\ub057\ud55c vendor_boot\ub97c \ubc31\uc5c5\ud558\uace0 \uc0c8 \ub864\ubc31 ZIP\uc744 PC\ub098 USB\uc5d0 \uc800\uc7a5\ud558\uc138\uc694. \ud29c\ub2dd \ud504\ub85c\ud544\uc740 \uadf8\ub300\ub85c \uc800\uc7a5\ub3fc \uc788\uc2b5\ub2c8\ub2e4. \uc5b4\ub290 \uc774\ubbf8\uc9c0\ub3c4 \ud50c\ub798\uc2dc\ud558\uc9c0 \uc54a\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "The phone will restart into OrangeFox. Press Volume Down during its initial 5-second countdown to cancel."

    const-string v1, "\ud734\ub300\uc804\ud654\uac00 OrangeFox\ub85c \ub2e4\uc2dc \uc2dc\uc791\ub429\ub2c8\ub2e4. \ucde8\uc18c\ud558\ub824\uba74 \ucc98\uc74c 5\ucd08 \uce74\uc6b4\ud2b8\ub2e4\uc6b4 \uc911\uc5d0 \ubcfc\ub968 \ud558 \ubc84\ud2bc\uc744 \ub204\ub974\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "The previous backup refresh belongs to a different image. Preserve and verify its rollback, journal and staged files in protected /data storage before freeing their cache space. Then create this ROM\'s clean backup. Save the NEW rollback ZIP to PC or USB before Apply. Your tuning profile stays saved. This does not flash any image."

    const-string v1, "\uc774\uc804 \ubc31\uc5c5 \uac31\uc2e0\uc740 \ub2e4\ub978 \uc774\ubbf8\uc9c0\uc758 \uac83\uc785\ub2c8\ub2e4. \uce90\uc2dc \uacf5\uac04\uc744 \ube44\uc6b0\uae30 \uc804\uc5d0 \uadf8 \ub864\ubc31, \uc800\ub110, \uc900\ube44 \ud30c\uc77c\uc744 \ubcf4\ud638\ub41c /data \uc800\uc7a5\uc18c\uc5d0 \ubcf4\uc874\ud558\uace0 \uac80\uc99d\ud558\uc138\uc694. \uadf8\ub2e4\uc74c \uc774 \ub86c\uc758 \uae68\ub057\ud55c \ubc31\uc5c5\uc744 \ub9cc\ub4dc\uc138\uc694. \uc801\uc6a9\ud558\uae30 \uc804\uc5d0 \uc0c8 \ub864\ubc31 ZIP\uc744 PC\ub098 USB\uc5d0 \uc800\uc7a5\ud558\uc138\uc694. \ud29c\ub2dd \ud504\ub85c\ud544\uc740 \uadf8\ub300\ub85c \uc800\uc7a5\ub3fc \uc788\uc2b5\ub2c8\ub2e4. \uc5b4\ub5a4 \uc774\ubbf8\uc9c0\ub3c4 \ud50c\ub798\uc2dc\ud558\uc9c0 \uc54a\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "The saved data was kept for recovery. "

    const-string v1, "\ubcf5\uad6c\ub97c \uc704\ud574 \uc800\uc7a5\ub41c \ub370\uc774\ud130\ub97c \uc720\uc9c0\ud588\uc2b5\ub2c8\ub2e4. "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "The settings provider rejected this change."

    const-string v1, "\uc124\uc815 \uc81c\uacf5\uc790\uac00 \uc774 \ubcc0\uacbd\uc744 \uac70\ubd80\ud588\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "This app or its shared UID is protected for recovery"

    const-string v1, "\uc774 \uc571 \ub610\ub294 \uacf5\uc720 UID\ub294 \ubcf5\uad6c\uc6a9\uc73c\ub85c \ubcf4\ud638\ub429\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "This changes the saved table structure. Remaining levels are renumbered and initial/minimum references adjusted. Keep at least two levels. Apply is a separate action."

    const-string v1, "\uc800\uc7a5\ub41c \ud14c\uc774\ube14 \uad6c\uc870\uac00 \ubc14\ub01d\ub2c8\ub2e4. \ub0a8\uc740 \ub2e8\uacc4\uc758 \ubc88\ud638\uac00 \ub2e4\uc2dc \ub9e4\uaca8\uc9c0\uace0 \ucd08\uae30/\ucd5c\uc18c \ucc38\uc870\uac00 \uc870\uc815\ub429\ub2c8\ub2e4. \ucd5c\uc18c \ub450 \ub2e8\uacc4\ub294 \ub0a8\uaca8\uc57c \ud569\ub2c8\ub2e4. \uc801\uc6a9\uc740 \ub530\ub85c \ud574\uc57c \ud569\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "This driver clamps active-row DDR requests above 9 to 9. "

    const-string v1, "\uc774 \ub4dc\ub77c\uc774\ubc84\ub294 \ud65c\uc131 \ud589\uc758 DDR \uc694\uccad\uc774 9\ub97c \ub118\uc73c\uba74 9\ub85c \uc81c\ud55c\ud569\ub2c8\ub2e4. "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "This profile deliberately sacrifices performance and background functions. Notifications, background sync, uploads, backups, app-store updates, widgets, VPNs and wearables can stop working. The screen becomes dim with a short timeout; CPU/GPU speed is heavily capped. Aggressive PCIe saving may expose driver instability. Play services, Play Store, Galaxy Store and non-essential system apps are restricted. Alarms, calls and connectivity can also fail. Core UIDs, Settings, SystemUI, credential and permission components, launcher, enabled keyboards, accessibility services and device administrators remain protected for recovery. Android exemptions and foreground services mean zero background activity is not guaranteed. Disable Battery Saving to restore saved settings; missed work and notifications cannot be recovered. Select the preset, then Save and apply."

    const-string v1, "\uc774 \ud504\ub85c\ud544\uc740 \uc131\ub2a5\uacfc \ubc31\uadf8\ub77c\uc6b4\ub4dc \uae30\ub2a5\uc744 \uc77c\ubd80\ub7ec \ud76c\uc0dd\ud569\ub2c8\ub2e4. \uc54c\ub9bc, \ubc31\uadf8\ub77c\uc6b4\ub4dc \ub3d9\uae30\ud654, \uc5c5\ub85c\ub4dc, \ubc31\uc5c5, \uc571 \uc2a4\ud1a0\uc5b4 \uc5c5\ub370\uc774\ud2b8, \uc704\uc82f, VPN, \uc6e8\uc5b4\ub7ec\ube14\uc774 \uc791\ub3d9\ud558\uc9c0 \uc54a\uc744 \uc218 \uc788\uc2b5\ub2c8\ub2e4. \ud654\uba74\uc774 \uc5b4\ub450\uc6cc\uc9c0\uace0 \ud654\uba74 \uaebc\uc9d0 \uc2dc\uac04\uc774 \uc9e7\uc544\uc9c0\uba70, CPU/GPU \uc18d\ub3c4\uac00 \ud06c\uac8c \uc81c\ud55c\ub429\ub2c8\ub2e4. \uac15\ud55c PCIe \uc808\uc804\uc73c\ub85c \ub4dc\ub77c\uc774\ubc84\uac00 \ubd88\uc548\uc815\ud574\uc9c8 \uc218 \uc788\uc2b5\ub2c8\ub2e4. Play \uc11c\ube44\uc2a4, Play \uc2a4\ud1a0\uc5b4, Galaxy Store\uc640 \ud544\uc218\uac00 \uc544\ub2cc \uc2dc\uc2a4\ud15c \uc571\uc774 \uc81c\ud55c\ub429\ub2c8\ub2e4. \uc54c\ub78c, \uc804\ud654, \uc5f0\uacb0\ub3c4 \uc2e4\ud328\ud560 \uc218 \uc788\uc2b5\ub2c8\ub2e4. \ud575\uc2ec UID, \uc124\uc815, SystemUI, \uc778\uc99d\u00b7\uad8c\ud55c \uad6c\uc131\uc694\uc18c, \ub7f0\ucc98, \uc0ac\uc6a9 \uc911\uc778 \ud0a4\ubcf4\ub4dc, \uc811\uadfc\uc131 \uc11c\ube44\uc2a4, \uae30\uae30 \uad00\ub9ac\uc790\ub294 \ubcf5\uad6c\ub97c \uc704\ud574 \ubcf4\ud638\ub429\ub2c8\ub2e4. Android \uc608\uc678\uc640 \ud3ec\uadf8\ub77c\uc6b4\ub4dc \uc11c\ube44\uc2a4 \ub54c\ubb38\uc5d0 \ubc31\uadf8\ub77c\uc6b4\ub4dc \ud65c\ub3d9\uc774 \uc644\uc804\ud788 \uc5c6\uc5b4\uc9c0\uc9c0\ub294 \uc54a\uc2b5\ub2c8\ub2e4. \ubc30\ud130\ub9ac \uc808\uc57d\uc744 \ub044\uba74 \uc800\uc7a5\ub41c \uc124\uc815\uc73c\ub85c \ub3cc\uc544\uac00\uc9c0\ub9cc, \ub193\uce5c \uc791\uc5c5\uacfc \uc54c\ub9bc\uc740 \ubcf5\uad6c\ub418\uc9c0 \uc54a\uc2b5\ub2c8\ub2e4. \ud504\ub9ac\uc14b\uc744 \uace0\ub978 \ub4a4 \uc800\uc7a5 \ubc0f \uc801\uc6a9\uc744 \ub204\ub974\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "This replaces the saved draft. Back up your profile first if you want to keep it."

    const-string v1, "\uc800\uc7a5\ub41c \ucd08\uc548\uc744 \ub300\uccb4\ud569\ub2c8\ub2e4. \uc720\uc9c0\ud558\ub824\uba74 \uba3c\uc800 \ud504\ub85c\ud544\uc744 \ubc31\uc5c5\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "This replaces your selected controls and turns Battery Saving off, restoring any current changes. Review the imported values before enabling it."

    const-string v1, "\uc120\ud0dd\ud55c \ud56d\ubaa9\uc744 \ub300\uccb4\ud558\uace0 \ubc30\ud130\ub9ac \uc808\uc57d\uc744 \ub044\uba74\uc11c \ud604\uc7ac \ubcc0\uacbd \uc0ac\ud56d\uc744 \ub418\ub3cc\ub9bd\ub2c8\ub2e4. \ucf1c\uae30 \uc804\uc5d0 \uac00\uc838\uc628 \uac12\uc744 \ud655\uc778\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "This restores the full vendor_boot image captured before this trial, including its original GPU table. Reboot after restoration succeeds."

    const-string v1, "\uc774\ubc88 \uc2dc\ud5d8 \uc801\uc6a9 \uc804\uc5d0 \uc800\uc7a5\ud55c vendor_boot \uc774\ubbf8\uc9c0 \uc804\uccb4\ub97c \uc6d0\ub798 GPU \ud14c\uc774\ube14\uacfc \ud568\uaed8 \ubcf5\uc6d0\ud569\ub2c8\ub2e4. \ubcf5\uc6d0\uc774 \uc131\uacf5\ud558\uba74 \uc7ac\ubd80\ud305\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "This shortcut is no longer available. Choose it again in Quick Tiles."

    const-string v1, "\uc774 \ubc14\ub85c\uac00\uae30\ub294 \ub354 \uc774\uc0c1 \uc0ac\uc6a9\ud560 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4. \ube60\ub978 \uc124\uc815 \ud0c0\uc77c\uc5d0\uc11c \ub2e4\uc2dc \uace0\ub974\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Tile icon"

    const-string v1, "\ud0c0\uc77c \uc544\uc774\ucf58"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Tile is in Quick Settings"

    const-string v1, "\ud0c0\uc77c\uc774 \ube60\ub978 \uc124\uc815\uc5d0 \uc788\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Tile label"

    const-string v1, "\ud0c0\uc77c \uc774\ub984"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Tile saved"

    const-string v1, "\ud0c0\uc77c \uc800\uc7a5\ub428"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Transition animations"

    const-string v1, "\uc804\ud658 \uc560\ub2c8\uba54\uc774\uc158"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Trial changes"

    const-string v1, "\uc2dc\ud5d8 \uc801\uc6a9 \ubcc0\uacbd \uc0ac\ud56d"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Tuning profile"

    const-string v1, "\ud29c\ub2dd \ud504\ub85c\ud544"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Turn off"

    const-string v1, "\ub044\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Turning this off restores the values saved before this feature changed them. Changes below take effect after Save and apply."

    const-string v1, "\ub044\uba74 \uc774 \uae30\ub2a5\uc774 \uac12\uc744 \ubc14\uafb8\uae30 \uc804\uc5d0 \uc800\uc7a5\ud574 \ub454 \uac12\uc73c\ub85c \ub3cc\uc544\uac11\ub2c8\ub2e4. \uc544\ub798 \ubcc0\uacbd \uc0ac\ud56d\uc740 \uc800\uc7a5 \ubc0f \uc801\uc6a9 \ud6c4 \ubc18\uc601\ub429\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "UN1CA Tile "

    const-string v1, "UN1CA \ud0c0\uc77c "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Unable to load installed apps"

    const-string v1, "\uc124\uce58\ub41c \uc571\uc744 \ubd88\ub7ec\uc62c \uc218 \uc5c6\uc74c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Unable to save tile"

    const-string v1, "\ud0c0\uc77c\uc744 \uc800\uc7a5\ud560 \uc218 \uc5c6\uc74c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Unavailable on this device"

    const-string v1, "\uc774 \uae30\uae30\uc5d0\uc11c\ub294 \uc0ac\uc6a9\ud560 \uc218 \uc5c6\uc74c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Unknown ("

    const-string v1, "\uc54c \uc218 \uc5c6\uc74c ("

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Unknown Installed"

    const-string v1, "\ucd9c\ucc98 \ubd88\uba85 \uc124\uce58 \uc571"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Unknown control: "

    const-string v1, "\uc54c \uc218 \uc5c6\ub294 \ud56d\ubaa9: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Unknown; imported upstream KonaBess export"

    const-string v1, "\uc54c \uc218 \uc5c6\uc74c; \uac00\uc838\uc628 \uc6d0\ubcf8 KonaBess \ub0b4\ubcf4\ub0b4\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Unsupported GPU property: "

    const-string v1, "\uc9c0\uc6d0\ub418\uc9c0 \uc54a\ub294 GPU \uc18d\uc131: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Up to six decimal places (1 Hz). Positive u32 Hz input only; this is a storage limit, not a supported clock range. Non-stock frequencies appear in red and can prevent booting."

    const-string v1, "\uc18c\uc218\uc810 \uc5ec\uc12f\uc9f8 \uc790\ub9ac(1 Hz)\uae4c\uc9c0 \uc785\ub825\ud560 \uc218 \uc788\uc2b5\ub2c8\ub2e4. \uc591\uc758 u32 Hz \uac12\ub9cc \ub429\ub2c8\ub2e4. \uc774\ub294 \uc800\uc7a5 \ud55c\ub3c4\uc77c \ubfd0 \uc9c0\uc6d0\ub418\ub294 \ud074\ub7ed \ubc94\uc704\uac00 \uc544\ub2d9\ub2c8\ub2e4. \uc21c\uc815\uc774 \uc544\ub2cc \uc8fc\ud30c\uc218\ub294 \ube68\uac04\uc0c9\uc73c\ub85c \ud45c\uc2dc\ub418\uba70 \ubd80\ud305\uc774 \uc548 \ub420 \uc218 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Update status"

    const-string v1, "\uc5c5\ub370\uc774\ud2b8 \uc0c1\ud0dc"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Updater setup: "

    const-string v1, "\uc5c5\ub370\uc774\ud130 \uc124\uc815: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Use experimental RPMh request?"

    const-string v1, "\uc2e4\ud5d8\uc801 RPMh \uc694\uccad \uac12\uc744 \uc0ac\uc6a9\ud560\uae4c\uc694?"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Use request"

    const-string v1, "\uc694\uccad \uac12 \uc0ac\uc6a9"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Values are saved automatically and retained across ROM updates that preserve Settings data. Imported values are never applied automatically."

    const-string v1, "\uac12\uc740 \uc790\ub3d9\uc73c\ub85c \uc800\uc7a5\ub418\uba70 \uc124\uc815 \ub370\uc774\ud130\ub97c \uc720\uc9c0\ud558\ub294 \ub86c \uc5c5\ub370\uc774\ud2b8 \ud6c4\uc5d0\ub3c4 \ub0a8\uc544 \uc788\uc2b5\ub2c8\ub2e4. \uac00\uc838\uc628 \uac12\uc740 \uc790\ub3d9\uc73c\ub85c \uc801\uc6a9\ub418\uc9c0 \uc54a\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Verification code"

    const-string v1, "\uc778\uc99d \ucf54\ub4dc"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Verifying OTA before reboot\u2026"

    const-string v1, "\uc7ac\ubd80\ud305 \uc804\uc5d0 OTA \uac80\uc99d \uc911\u2026"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Verifying selected OTA\u2026"

    const-string v1, "\uc120\ud0dd\ud55c OTA \uac80\uc99d \uc911\u2026"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Vibrate"

    const-string v1, "\uc9c4\ub3d9"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Voltage request \u00b7 table "

    const-string v1, "\uc804\uc555 \uc694\uccad \u00b7 \ud14c\uc774\ube14 "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Wait for the GPU operation to finish"

    const-string v1, "GPU \uc791\uc5c5\uc774 \ub05d\ub0a0 \ub54c\uae4c\uc9c0 \uae30\ub2e4\ub9ac\uc138\uc694"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Wait for the battery operation to finish"

    const-string v1, "\ubc30\ud130\ub9ac \uc791\uc5c5\uc774 \ub05d\ub0a0 \ub54c\uae4c\uc9c0 \uae30\ub2e4\ub9ac\uc138\uc694"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Wait for the update operation to finish"

    const-string v1, "\uc5c5\ub370\uc774\ud2b8 \uc791\uc5c5\uc774 \ub05d\ub0a0 \ub54c\uae4c\uc9c0 \uae30\ub2e4\ub9ac\uc138\uc694"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Wi-Fi Calling discovery unavailable: "

    const-string v1, "Wi-Fi \ud1b5\ud654 \uc815\ubcf4\ub97c \ud655\uc778\ud560 \uc218 \uc5c6\uc74c: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Wi-Fi Calling \u00b7 SIM "

    const-string v1, "Wi-Fi \ud1b5\ud654 \u00b7 SIM "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Window animations"

    const-string v1, "\ucc3d \uc560\ub2c8\uba54\uc774\uc158"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Wireless debugging settings"

    const-string v1, "\ubb34\uc120 \ub514\ubc84\uae45 \uc124\uc815"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Working set"

    const-string v1, "\uc791\uc5c5 \uc138\ud2b8"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Working set (20)"

    const-string v1, "\uc791\uc5c5 \uc138\ud2b8 (20)"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Working: "

    const-string v1, "\uc9c4\ud589 \uc911: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Write both GPU tables to vendor_boot?"

    const-string v1, "GPU \ud14c\uc774\ube14 \ub450 \uac1c\ub97c vendor_boot\uc5d0 \uc4f8\uae4c\uc694?"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "its app is open"

    const-string v1, "\ud574\ub2f9 \uc571\uc774 \uc5f4\ub824 \uc788\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "not shown: island hidden (lock screen, full screen or landscape)"

    const-string v1, "\ud45c\uc2dc \uc548 \ub428: \uc544\uc77c\ub79c\ub4dc \uc228\uae40 (\uc7a0\uae08 \ud654\uba74, \uc804\uccb4 \ud654\uba74 \ub610\ub294 \uac00\ub85c \ubaa8\ub4dc)"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "not shown: the island could not open"

    const-string v1, "\ud45c\uc2dc \uc548 \ub428: \uc544\uc77c\ub79c\ub4dc\ub97c \uc5f4 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "not shown: the messages app is open"

    const-string v1, "\ud45c\uc2dc \uc548 \ub428: \uba54\uc2dc\uc9c0 \uc571\uc774 \uc5f4\ub824 \uc788\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "required before Apply"

    const-string v1, "\uc801\uc6a9 \uc804\uc5d0 \ud544\uc694"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "the notification settings are off"

    const-string v1, "\uc54c\ub9bc \uc124\uc815\uc774 \uaebc\uc838 \uc788\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private static fill3(Ljava/util/HashMap;)V
    .locals 2

    const-string v0, "About GPU tuning"

    const-string v1, "GPU \ud29c\ub2dd \uc548\ub0b4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "About this check"

    const-string v1, "\uc774 \uac80\uc0ac\uc5d0 \ub300\ud558\uc5ec"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Accepted LSPosed review: "

    const-string v1, "LSPosed \uac80\ud1a0 \uc218\ub77d: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Action history"

    const-string v1, "\uc791\uc5c5 \uae30\ub85d"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Active AI backend is not ready."

    const-string v1, "\ud65c\uc131 AI \ubc31\uc5d4\ub4dc\uac00 \uc900\ube44\ub418\uc9c0 \uc54a\uc558\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Active AI backend is not ready. Prepare its model or API settings first."

    const-string v1, "\ud65c\uc131 AI \ubc31\uc5d4\ub4dc\uac00 \uc900\ube44\ub418\uc9c0 \uc54a\uc558\uc2b5\ub2c8\ub2e4. \uba3c\uc800 \ubaa8\ub378\uc774\ub098 API \uc124\uc815\uc744 \uc900\ube44\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Activity status timed out"

    const-string v1, "\ud65c\ub3d9 \uc0c1\ud0dc \ud655\uc778 \uc2dc\uac04 \ucd08\uacfc"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Adaptive brightness"

    const-string v1, "\ubc1d\uae30 \uc790\ub3d9 \uc870\uc808"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Advanced: raw u32 bus requests must satisfy min \u2264 frequency \u2264 max. This driver clamps requests above 9 on active rows; the final row must use 0\u20139. ACD is a raw bitfield. Changes can prevent booting."

    const-string v1, "\uace0\uae09: u32 \ubc84\uc2a4 \uc694\uccad \uc6d0\uc2dc\uac12\uc740 \ucd5c\uc18c \u2264 \uc8fc\ud30c\uc218 \u2264 \ucd5c\ub300\ub97c \ub9cc\uc871\ud574\uc57c \ud569\ub2c8\ub2e4. \uc774 \ub4dc\ub77c\uc774\ubc84\ub294 \ud65c\uc131 \ud589\uc5d0\uc11c 9\ub97c \ub118\ub294 \uc694\uccad\uc744 \uc81c\ud55c\ud558\uba70, \ub9c8\uc9c0\ub9c9 \ud589\uc740 0\u20139\ub97c \uc0ac\uc6a9\ud574\uc57c \ud569\ub2c8\ub2e4. ACD\ub294 \uc6d0\uc2dc \ube44\ud2b8\ud544\ub4dc\uc785\ub2c8\ub2e4. \ubcc0\uacbd\ud558\uba74 \ubd80\ud305\ub418\uc9c0 \uc54a\uc744 \uc218 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Aggressive app restrictions"

    const-string v1, "\uac15\ub825\ud55c \uc571 \uc81c\ud55c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Agree and send online"

    const-string v1, "\ub3d9\uc758\ud558\uace0 \uc628\ub77c\uc778\uc73c\ub85c \ubcf4\ub0b4\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Always dark can reduce OLED display power in apps that follow the theme. App-specific themes and wallpaper are unchanged."

    const-string v1, "\ud56d\uc0c1 \ub2e4\ud06c \ubaa8\ub4dc\ub294 \ud14c\ub9c8\ub97c \ub530\ub974\ub294 \uc571\uc5d0\uc11c OLED \ud654\uba74 \uc804\ub825\uc744 \uc904\uc77c \uc218 \uc788\uc2b5\ub2c8\ub2e4. \uc571\ubcc4 \ud14c\ub9c8\uc640 \ubc30\uacbd\ud654\uba74\uc740 \ubc14\ub00c\uc9c0 \uc54a\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Analysis cancellation requested."

    const-string v1, "\ubd84\uc11d \ucde8\uc18c\ub97c \uc694\uccad\ud588\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Analysis cancelled"

    const-string v1, "\ubd84\uc11d \ucde8\uc18c\ub428"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Analysis finished. Expand a result below to read it. Suggested causes require verification."

    const-string v1, "\ubd84\uc11d\uc774 \ub05d\ub0ac\uc2b5\ub2c8\ub2e4. \uc544\ub798 \uacb0\uacfc\ub97c \ud3bc\uccd0\uc11c \ud655\uc778\ud558\uc138\uc694. \uc81c\uc2dc\ub41c \uc6d0\uc778\uc740 \uc9c1\uc811 \ud655\uc778\uc774 \ud544\uc694\ud569\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Analysis stopped. Some selected log sections were not analyzed."

    const-string v1, "\ubd84\uc11d\uc774 \uc911\ub2e8\ub418\uc5c8\uc2b5\ub2c8\ub2e4. \uc120\ud0dd\ud55c \ub85c\uadf8 \uad6c\uac04 \uc911 \uc77c\ubd80\ub294 \ubd84\uc11d\ub418\uc9c0 \uc54a\uc558\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Analyze logs"

    const-string v1, "\ub85c\uadf8 \ubd84\uc11d"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Analyze selected sections"

    const-string v1, "\uc120\ud0dd\ud55c \uad6c\uac04 \ubd84\uc11d"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Analyzing log section "

    const-string v1, "\ub85c\uadf8 \uad6c\uac04 \ubd84\uc11d \uc911 "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Analyzing selected crash details\u2026"

    const-string v1, "\uc120\ud0dd\ud55c \ud06c\ub798\uc2dc \uc815\ubcf4 \ubd84\uc11d \uc911\u2026"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Android Battery Saver"

    const-string v1, "Android \uc808\uc804 \ubaa8\ub4dc"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Android keeps this app Exempted (5); bucket change skipped"

    const-string v1, "Android\uac00 \uc774 \uc571\uc744 \uc608\uc678(5)\ub85c \uc720\uc9c0\ud558\ubbc0\ub85c \ubc84\ud0b7 \ubcc0\uacbd\uc744 \uac74\ub108\ub701\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Android rejected the setting"

    const-string v1, "Android\uac00 \uc124\uc815\uc744 \uac70\ubd80\ud588\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Answer copied"

    const-string v1, "\ub2f5\ubcc0\uc744 \ubcf5\uc0ac\ud588\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Answer exceeds display limit"

    const-string v1, "\ub2f5\ubcc0\uc774 \ud45c\uc2dc \ud55c\ub3c4\ub97c \ub118\uc5c8\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Answer received. Ask a follow-up using the included history, or select another log section. The current section is not repeated unless you check Include. Verify suggestions before applying changes."

    const-string v1, "\ub2f5\ubcc0\uc744 \ubc1b\uc558\uc2b5\ub2c8\ub2e4. \ud3ec\ud568\ub41c \uae30\ub85d\uc73c\ub85c \uc774\uc5b4\uc11c \uc9c8\ubb38\ud558\uac70\ub098 \ub2e4\ub978 \ub85c\uadf8 \uad6c\uac04\uc744 \uc120\ud0dd\ud558\uc138\uc694. \ud3ec\ud568\uc744 \uccb4\ud06c\ud558\uc9c0 \uc54a\uc73c\uba74 \ud604\uc7ac \uad6c\uac04\uc740 \ub2e4\uc2dc \ubcf4\ub0b4\uc9c0 \uc54a\uc2b5\ub2c8\ub2e4. \ubcc0\uacbd\ud558\uae30 \uc804\uc5d0 \uc81c\uc548 \ub0b4\uc6a9\uc744 \ud655\uc778\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "App could not open"

    const-string v1, "\uc571 \uc2e4\ud589 \uc2e4\ud328"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "App crash"

    const-string v1, "\uc571 \ud06c\ub798\uc2dc"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "App identity changed; refusing UID policy write"

    const-string v1, "\uc571 \uc815\ubcf4\uac00 \ubc14\ub00c\uc5b4 UID \uc815\ucc45 \uc4f0\uae30\ub97c \uac70\ubd80\ud569\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "App is no longer Exempted (5); refresh the list before selecting it"

    const-string v1, "\uc571\uc774 \ub354 \uc774\uc0c1 \uc608\uc678(5)\uac00 \uc544\ub2d9\ub2c8\ub2e4. \ubaa9\ub85d\uc744 \uc0c8\ub85c\uace0\uce68\ud55c \ub4a4 \uc120\ud0dd\ud558\uc138\uc694"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "App not responding"

    const-string v1, "\uc571 \uc751\ub2f5 \uc5c6\uc74c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "App shortcut"

    const-string v1, "\uc571 \ubc14\ub85c\uac00\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "App to hide"

    const-string v1, "\uc228\uae38 \uc571"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "App to spoof"

    const-string v1, "\uc2a4\ud478\ud551\ud560 \uc571"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Application presets"

    const-string v1, "\uc571 \ud504\ub9ac\uc14b"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Ask aI"

    const-string v1, "AI\uc5d0\uac8c \ubb3b\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Ask about a problem, paste a log, or attach a text file. Up to 12 recent exchanges stay in memory until Troubleshooting closes. AI suggestions require verification."

    const-string v1, "\ubb38\uc81c\ub97c \ubb3c\uc5b4\ubcf4\uac70\ub098 \ub85c\uadf8\ub97c \ubd99\uc5ec\ub123\uac70\ub098 \ud14d\uc2a4\ud2b8 \ud30c\uc77c\uc744 \ucca8\ubd80\ud558\uc138\uc694. \ubb38\uc81c \ud574\uacb0\uc744 \ub2eb\uae30 \uc804\uae4c\uc9c0 \ucd5c\uadfc \ub300\ud654 12\uac1c\uac00 \uae30\uc5b5\ub429\ub2c8\ub2e4. AI \uc81c\uc548\uc740 \uc9c1\uc811 \ud655\uc778\uc774 \ud544\uc694\ud569\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Ask on device"

    const-string v1, "\uae30\uae30\uc5d0\uc11c \ubb3b\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Asking your selected AI backend\u2026"

    const-string v1, "\uc120\ud0dd\ud55c AI \ubc31\uc5d4\ub4dc\uc5d0 \ubb3b\ub294 \uc911\u2026"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Attach text / log file"

    const-string v1, "\ud14d\uc2a4\ud2b8 / \ub85c\uadf8 \ud30c\uc77c \ucca8\ubd80"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Auto allows runtime sleep. On can bypass a faulty suspend/resume loop, but may increase drain."

    const-string v1, "\uc790\ub3d9\uc740 \ub7f0\ud0c0\uc784 \uc808\uc804\uc744 \ud5c8\uc6a9\ud569\ub2c8\ub2e4. \ucf1c\uba74 \uc798\ubabb\ub41c \uc808\uc804/\ubcf5\uadc0 \ubc18\ubcf5\uc744 \ud53c\ud560 \uc218 \uc788\uc9c0\ub9cc \ubc30\ud130\ub9ac \uc18c\ubaa8\uac00 \ub298 \uc218 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Automatic account sync"

    const-string v1, "\uacc4\uc815 \uc790\ub3d9 \ub3d9\uae30\ud654"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Available to the device owner\'s Settings only"

    const-string v1, "\uae30\uae30 \uc18c\uc720\uc790\uc758 \uc124\uc815\uc5d0\uc11c\ub9cc \uc0ac\uc6a9\ud560 \uc218 \uc788\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Back to Troubleshooting"

    const-string v1, "\ubb38\uc81c \ud574\uacb0\ub85c \ub3cc\uc544\uac00\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Back to edit"

    const-string v1, "\ud3b8\uc9d1\uc73c\ub85c \ub3cc\uc544\uac00\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Backend ready. Review your message and log before sending."

    const-string v1, "\ubc31\uc5d4\ub4dc \uc900\ube44 \uc644\ub8cc. \ubcf4\ub0b4\uae30 \uc804\uc5d0 \uba54\uc2dc\uc9c0\uc640 \ub85c\uadf8\ub97c \ud655\uc778\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Bad legacy index"

    const-string v1, "\uc798\ubabb\ub41c \ub808\uac70\uc2dc \uc778\ub371\uc2a4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Balances ZRAM work against reclaim and app reloads. A lower value does not guarantee lower power consumption."

    const-string v1, "ZRAM \uc791\uc5c5\uacfc \uba54\ubaa8\ub9ac \ud68c\uc218\u00b7\uc571 \uc7ac\ub85c\ub4dc \uc0ac\uc774\uc758 \uade0\ud615\uc744 \uc870\uc808\ud569\ub2c8\ub2e4. \uac12\uc774 \ub0ae\ub2e4\uace0 \uc804\ub825 \uc18c\ubaa8\uac00 \uc904\uc5b4\ub4dc\ub294 \uac83\uc740 \uc544\ub2d9\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Battery Saver request rejected (possibly charging)"

    const-string v1, "\uc808\uc804 \ubaa8\ub4dc \uc694\uccad\uc774 \uac70\ubd80\ub418\uc5c8\uc2b5\ub2c8\ub2e4 (\ucda9\uc804 \uc911\uc77c \uc218 \uc788\uc74c)"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Battery Saving is available to the device owner\'s Settings only"

    const-string v1, "\ubc30\ud130\ub9ac \uc808\uc57d\uc740 \uae30\uae30 \uc18c\uc720\uc790\uc758 \uc124\uc815\uc5d0\uc11c\ub9cc \uc0ac\uc6a9\ud560 \uc218 \uc788\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Battery Saving service is not installed. Install the updated ROM."

    const-string v1, "\ubc30\ud130\ub9ac \uc808\uc57d \uc11c\ube44\uc2a4\uac00 \uc124\uce58\ub418\uc5b4 \uc788\uc9c0 \uc54a\uc2b5\ub2c8\ub2e4. \ucd5c\uc2e0 \ub86c\uc744 \uc124\uce58\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Battery kernel service did not respond. Refresh status before retrying."

    const-string v1, "\ubc30\ud130\ub9ac \ucee4\ub110 \uc11c\ube44\uc2a4\uac00 \uc751\ub2f5\ud558\uc9c0 \uc54a\uc558\uc2b5\ub2c8\ub2e4. \uc0c1\ud0dc\ub97c \uc0c8\ub85c\uace0\uce68\ud55c \ub4a4 \ub2e4\uc2dc \uc2dc\ub3c4\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Battery message too large"

    const-string v1, "\ubc30\ud130\ub9ac \uba54\uc2dc\uc9c0\uac00 \ub108\ubb34 \ud07d\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Bluetooth scanning while off"

    const-string v1, "\uaebc\uc838 \uc788\uc744 \ub54c \ube14\ub8e8\ud22c\uc2a4 \uac80\uc0c9"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Bluetooth settings"

    const-string v1, "\ube14\ub8e8\ud22c\uc2a4 \uc124\uc815"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Boot profile failed"

    const-string v1, "\ubd80\ud305 \ud504\ub85c\ud544 \uc801\uc6a9 \uc2e4\ud328"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Boot property"

    const-string v1, "\ubd80\ud305 \uc18d\uc131"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Bus and ACD"

    const-string v1, "\ubc84\uc2a4 \ubc0f ACD"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Bus/ACD differs from stock. "

    const-string v1, "\ubc84\uc2a4/ACD\uac00 \uc21c\uc815\uacfc \ub2e4\ub985\ub2c8\ub2e4. "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Cached-app freezer"

    const-string v1, "\uce90\uc2dc\ub41c \uc571 \ub3d9\uacb0"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Cached-process limit"

    const-string v1, "\uce90\uc2dc \ud504\ub85c\uc138\uc2a4 \ud55c\ub3c4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Camera feature XML imported. Open Samsung Camera to load it."

    const-string v1, "\uce74\uba54\ub77c \uae30\ub2a5 XML\uc744 \uac00\uc838\uc654\uc2b5\ub2c8\ub2e4. \uc0bc\uc131 \uce74\uba54\ub77c\ub97c \uc5f4\uba74 \uc801\uc6a9\ub429\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Camera feature override reset."

    const-string v1, "\uce74\uba54\ub77c \uae30\ub2a5 \uc7ac\uc815\uc758\ub97c \ucd08\uae30\ud654\ud588\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Camera feature saved. Samsung Camera was reloaded."

    const-string v1, "\uce74\uba54\ub77c \uae30\ub2a5\uc744 \uc800\uc7a5\ud588\uc2b5\ub2c8\ub2e4. \uc0bc\uc131 \uce74\uba54\ub77c\ub97c \ub2e4\uc2dc \ubd88\ub7ec\uc654\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Cancel analysis"

    const-string v1, "\ubd84\uc11d \ucde8\uc18c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Cancel request"

    const-string v1, "\uc694\uccad \ucde8\uc18c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Cannot create battery profile storage"

    const-string v1, "\ubc30\ud130\ub9ac \ud504\ub85c\ud544 \uc800\uc7a5\uc18c\ub97c \ub9cc\ub4e4 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Cannot open backup"

    const-string v1, "\ubc31\uc5c5\uc744 \uc5f4 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Cannot open certificate"

    const-string v1, "\uc778\uc99d\uc11c\ub97c \uc5f4 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Cannot open destination"

    const-string v1, "\uc800\uc7a5 \uc704\uce58\ub97c \uc5f4 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Cannot open file"

    const-string v1, "\ud30c\uc77c\uc744 \uc5f4 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Cannot open profile"

    const-string v1, "\ud504\ub85c\ud544\uc744 \uc5f4 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Cannot prepare log storage"

    const-string v1, "\ub85c\uadf8 \uc800\uc7a5\uc18c\ub97c \uc900\ube44\ud560 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Cannot read profile"

    const-string v1, "\ud504\ub85c\ud544\uc744 \uc77d\uc744 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Cannot save certificate configuration"

    const-string v1, "\uc778\uc99d\uc11c \uc124\uc815\uc744 \uc800\uc7a5\ud560 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Cannot save tuning profile"

    const-string v1, "\ud29c\ub2dd \ud504\ub85c\ud544\uc744 \uc800\uc7a5\ud560 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Cannot schedule battery profile"

    const-string v1, "\ubc30\ud130\ub9ac \ud504\ub85c\ud544\uc744 \uc608\uc57d\ud560 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Cannot set certificate permissions"

    const-string v1, "\uc778\uc99d\uc11c \uad8c\ud55c\uc744 \uc124\uc815\ud560 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Cannot verify saved ZIP"

    const-string v1, "\uc800\uc7a5\ub41c ZIP\uc744 \uac80\uc99d\ud560 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Cannot write selected document"

    const-string v1, "\uc120\ud0dd\ud55c \ubb38\uc11c\uc5d0 \uc4f8 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Certificate exceeds 64 KiB"

    const-string v1, "\uc778\uc99d\uc11c\uac00 64 KiB\ub97c \ub118\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Certificate is already imported"

    const-string v1, "\uc774\ubbf8 \uac00\uc838\uc628 \uc778\uc99d\uc11c\uc785\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Changes from the current image:\n"

    const-string v1, "\ud604\uc7ac \uc774\ubbf8\uc9c0\uc640 \ub2ec\ub77c\uc9c0\ub294 \uc810:\n"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Chat with your active AI backend \u00b7 paste or attach a log"

    const-string v1, "\ud65c\uc131 AI \ubc31\uc5d4\ub4dc\uc640 \ub300\ud654 \u00b7 \ub85c\uadf8 \ubd99\uc5ec\ub123\uae30 \ub610\ub294 \ucca8\ubd80"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Check PIF and TEE setup"

    const-string v1, "PIF \ubc0f TEE \uc124\uc815 \uc810\uac80"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Check completed. Review configuration and runtime results below."

    const-string v1, "\uc810\uac80\uc774 \ub05d\ub0ac\uc2b5\ub2c8\ub2e4. \uc544\ub798\uc5d0\uc11c \uc124\uc815\uacfc \uc2e4\ud589 \uacb0\uacfc\ub97c \ud655\uc778\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Check incomplete"

    const-string v1, "\uc810\uac80 \ubbf8\uc644\ub8cc"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Check root modules and enabled LSPosed conflicts"

    const-string v1, "\ub8e8\ud2b8 \ubaa8\ub4c8\uacfc \ud65c\uc131 LSPosed \ucda9\ub3cc \uc810\uac80"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Checked "

    const-string v1, "\uc810\uac80\ud568 "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Checking PIF settings, TEE profiles and runtime evidence\u2026"

    const-string v1, "PIF \uc124\uc815, TEE \ud504\ub85c\ud544, \uc2e4\ud589 \uadfc\uac70\ub97c \ud655\uc778\ud558\ub294 \uc911\u2026"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Checking active backend\u2026"

    const-string v1, "\ud65c\uc131 \ubc31\uc5d4\ub4dc \ud655\uc778 \uc911\u2026"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Checking available controls\u2026"

    const-string v1, "\uc0ac\uc6a9 \uac00\ub2a5\ud55c \ud56d\ubaa9 \ud655\uc778 \uc911\u2026"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Checking battery service\u2026"

    const-string v1, "\ubc30\ud130\ub9ac \uc11c\ube44\uc2a4 \ud655\uc778 \uc911\u2026"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Checking firmware compatibility\u2026"

    const-string v1, "\ud38c\uc6e8\uc5b4 \ud638\ud658\uc131 \ud655\uc778 \uc911\u2026"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Checking your active AI backend\u2026"

    const-string v1, "\ud65c\uc131 AI \ubc31\uc5d4\ub4dc \ud655\uc778 \uc911\u2026"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Choose a shortcut published by an installed app. Available shortcuts can change when the app is updated."

    const-string v1, "\uc124\uce58\ub41c \uc571\uc774 \uc81c\uacf5\ud558\ub294 \ubc14\ub85c\uac00\uae30\ub97c \uc120\ud0dd\ud558\uc138\uc694. \uc571\uc774 \uc5c5\ub370\uc774\ud2b8\ub418\uba74 \ubc14\ub85c\uac00\uae30 \ubaa9\ub85d\uc774 \ubc14\ub014 \uc218 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Choose a text log to review"

    const-string v1, "\uac80\ud1a0\ud560 \ud14d\uc2a4\ud2b8 \ub85c\uadf8 \uc120\ud0dd"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Choose an app first"

    const-string v1, "\uba3c\uc800 \uc571\uc744 \uc120\ud0dd\ud558\uc138\uc694"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Choose an app shortcut first"

    const-string v1, "\uba3c\uc800 \uc571 \ubc14\ub85c\uac00\uae30\ub97c \uc120\ud0dd\ud558\uc138\uc694"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Choose app"

    const-string v1, "\uc571 \uc120\ud0dd"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Clear chat history, your draft and the attached log from this session."

    const-string v1, "\uc774 \uc138\uc158\uc758 \ub300\ud654 \uae30\ub85d, \uc791\uc131 \uc911\uc778 \ub0b4\uc6a9, \ucca8\ubd80\ud55c \ub85c\uadf8\ub97c \uc9c0\uc6c1\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Clear conversation"

    const-string v1, "\ub300\ud654 \uc9c0\uc6b0\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Clear conversation?"

    const-string v1, "\ub300\ud654\ub97c \uc9c0\uc6b8\uae4c\uc694?"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Clipboard has no text."

    const-string v1, "\ud074\ub9bd\ubcf4\ub4dc\uc5d0 \ud14d\uc2a4\ud2b8\uac00 \uc5c6\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Collect or import a log to find crashes and app failures."

    const-string v1, "\ud06c\ub798\uc2dc\uc640 \uc571 \uc624\ub958\ub97c \ucc3e\uc73c\ub824\uba74 \ub85c\uadf8\ub97c \uc218\uc9d1\ud558\uac70\ub098 \uac00\uc838\uc624\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Collect recent device log"

    const-string v1, "\ucd5c\uadfc \uae30\uae30 \ub85c\uadf8 \uc218\uc9d1"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Collecting recent logcat\u2026"

    const-string v1, "\ucd5c\uadfc logcat \uc218\uc9d1 \uc911\u2026"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Completed with Android policy limits; review details below"

    const-string v1, "Android \uc815\ucc45 \uc81c\ud55c\uc774 \uc788\ub294 \uc0c1\ud0dc\ub85c \uc644\ub8cc\ub418\uc5c8\uc2b5\ub2c8\ub2e4. \uc544\ub798 \ub0b4\uc6a9\uc744 \ud655\uc778\ud558\uc138\uc694"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Configuration, runtime evidence and verification steps"

    const-string v1, "\uc124\uc815, \uc2e4\ud589 \uadfc\uac70, \ud655\uc778 \ubc29\ubc95"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Configured \u2014 "

    const-string v1, "\uc124\uc815\ub428 \u2014 "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Configured \u2014 PIF enabled; explicit overrides passed format/size checks. Empty fields use ROM defaults, whose effective values are not independently validated."

    const-string v1, "\uc124\uc815\ub428 \u2014 PIF\uac00 \ucf1c\uc838 \uc788\uace0 \uc9c1\uc811 \uc785\ub825\ud55c \uac12\uc774 \ud615\uc2dd/\ud06c\uae30 \uac80\uc0ac\ub97c \ud1b5\uacfc\ud588\uc2b5\ub2c8\ub2e4. \ube48 \ud56d\ubaa9\uc740 \ub86c \uae30\ubcf8\uac12\uc744 \uc4f0\uba70, \uadf8 \uc2e4\uc81c \uac12\uc740 \ub530\ub85c \uac80\uc99d\ud558\uc9c0 \uc54a\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Conflicts with UN1CA mod: "

    const-string v1, "UN1CA \uae30\ub2a5\uacfc \ucda9\ub3cc: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Connect to Wi-Fi first"

    const-string v1, "\uba3c\uc800 Wi-Fi\uc5d0 \uc5f0\uacb0\ud558\uc138\uc694"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Control characters in profile text"

    const-string v1, "\ud504\ub85c\ud544 \ud14d\uc2a4\ud2b8\uc5d0 \uc81c\uc5b4 \ubb38\uc790\uac00 \uc788\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Conversation cleared."

    const-string v1, "\ub300\ud654\ub97c \uc9c0\uc6e0\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Copy answer"

    const-string v1, "\ub2f5\ubcc0 \ubcf5\uc0ac"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Copy plain text before pasting a log."

    const-string v1, "\ub85c\uadf8\ub97c \ubd99\uc5ec\ub123\uae30 \uc804\uc5d0 \uc77c\ubc18 \ud14d\uc2a4\ud2b8\ub97c \ubcf5\uc0ac\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Could not export camera-feature.xml."

    const-string v1, "camera-feature.xml\uc744 \ub0b4\ubcf4\ub0b4\uc9c0 \ubabb\ud588\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Could not import camera-feature.xml."

    const-string v1, "camera-feature.xml\uc744 \uac00\uc838\uc624\uc9c0 \ubabb\ud588\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Could not reset camera feature override."

    const-string v1, "\uce74\uba54\ub77c \uae30\ub2a5 \uc7ac\uc815\uc758\ub97c \ucd08\uae30\ud654\ud558\uc9c0 \ubabb\ud588\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Could not save camera feature value."

    const-string v1, "\uce74\uba54\ub77c \uae30\ub2a5 \uac12\uc744 \uc800\uc7a5\ud558\uc9c0 \ubabb\ud588\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Coverage limited. "

    const-string v1, "\ud655\uc778 \ubc94\uc704 \uc81c\ud55c\ub428. "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Coverage: "

    const-string v1, "\ud655\uc778 \ubc94\uc704: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Crash buffer access unavailable"

    const-string v1, "\ud06c\ub798\uc2dc \ubc84\ud37c\uc5d0 \uc811\uadfc\ud560 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Crash buffer collection timed out"

    const-string v1, "\ud06c\ub798\uc2dc \ubc84\ud37c \uc218\uc9d1 \uc2dc\uac04 \ucd08\uacfc"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Crash details"

    const-string v1, "\ud06c\ub798\uc2dc \uc815\ubcf4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Create backup for current ROM"

    const-string v1, "\ud604\uc7ac \ub86c \ubc31\uc5c5 \ub9cc\ub4e4\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Create or verify original backup"

    const-string v1, "\uc6d0\ubcf8 \ubc31\uc5c5 \ub9cc\ub4e4\uae30 \ub610\ub294 \ud655\uc778"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Custom schedule"

    const-string v1, "\uc0ac\uc6a9\uc790 \uc9c0\uc815 \uc77c\uc815"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Dark-mode schedule type was not restored"

    const-string v1, "\ub2e4\ud06c \ubaa8\ub4dc \uc77c\uc815 \uc720\ud615\uc774 \ubcf5\uc6d0\ub418\uc9c0 \uc54a\uc558\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Data Saver"

    const-string v1, "\ub370\uc774\ud130 \uc808\uc57d \ubaa8\ub4dc"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Debugging is restricted by your administrator"

    const-string v1, "\uad00\ub9ac\uc790\uac00 \ub514\ubc84\uae45\uc744 \uc81c\ud55c\ud588\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Describe the problem or ask a follow-up question"

    const-string v1, "\ubb38\uc81c\ub97c \uc124\uba85\ud558\uac70\ub098 \uc774\uc5b4\uc11c \uc9c8\ubb38\ud558\uc138\uc694"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Describe the problem or ask a question first."

    const-string v1, "\uba3c\uc800 \ubb38\uc81c\ub97c \uc124\uba85\ud558\uac70\ub098 \uc9c8\ubb38\uc744 \uc785\ub825\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Device configuration rejected the change"

    const-string v1, "\uae30\uae30 \uc124\uc815\uc774 \ubcc0\uacbd\uc744 \uac70\ubd80\ud588\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Device status checked"

    const-string v1, "\uae30\uae30 \uc0c1\ud0dc \ud655\uc778\ub428"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Device-tree cell overflows u32"

    const-string v1, "\ub514\ubc14\uc774\uc2a4 \ud2b8\ub9ac \uc140\uc774 u32 \ubc94\uc704\ub97c \ub118\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Dial a number"

    const-string v1, "\uc804\ud654 \uac78\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Disable this module?"

    const-string v1, "\uc774 \ubaa8\ub4c8\uc744 \ube44\ud65c\uc131\ud654\ud560\uae4c\uc694?"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Disables always-available BLE scans; can impair location and nearby-device discovery."

    const-string v1, "\ud56d\uc0c1 \ucf1c\uc9c4 BLE \uac80\uc0c9\uc744 \ub055\ub2c8\ub2e4. \uc704\uce58 \uc815\ud655\ub3c4\uc640 \uc8fc\ubcc0 \uae30\uae30 \ucc3e\uae30\uc5d0 \uc601\ud5a5\uc774 \uc788\uc744 \uc218 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Disables always-available Wi-Fi scans; reduces location accuracy."

    const-string v1, "\ud56d\uc0c1 \ucf1c\uc9c4 Wi-Fi \uac80\uc0c9\uc744 \ub055\ub2c8\ub2e4. \uc704\uce58 \uc815\ud655\ub3c4\uac00 \ub5a8\uc5b4\uc9d1\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Disabling wake events may delay Wi-Fi notifications or background communication."

    const-string v1, "\uae68\uc6b0\uae30 \uc774\ubca4\ud2b8\ub97c \ub044\uba74 Wi-Fi \uc54c\ub9bc\uc774\ub098 \ubc31\uadf8\ub77c\uc6b4\ub4dc \ud1b5\uc2e0\uc774 \ub2a6\uc5b4\uc9c8 \uc218 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Display refresh-rate ceiling"

    const-string v1, "\ud654\uba74 \uc8fc\uc0ac\uc728 \uc0c1\ud55c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Duplicate GPU property"

    const-string v1, "\uc911\ubcf5\ub41c GPU \uc18d\uc131"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Edit table"

    const-string v1, "\ud45c \ud3b8\uc9d1"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Enable Developer options first"

    const-string v1, "\uba3c\uc800 \uac1c\ubc1c\uc790 \uc635\uc158\uc744 \ucf1c\uc138\uc694"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Enabled \u00b7 restart state unverified"

    const-string v1, "\ud65c\uc131\ud654\ub428 \u00b7 \uc7ac\uc2dc\uc791 \uc0c1\ud0dc \ubbf8\ud655\uc778"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Enter a DNS provider hostname, such as dns.google"

    const-string v1, "DNS \uc81c\uacf5\uc790 \ud638\uc2a4\ud2b8 \uc774\ub984\uc744 \uc785\ub825\ud558\uc138\uc694 (\uc608: dns.google)"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Enter a tile label"

    const-string v1, "\ud0c0\uc77c \uc774\ub984\uc744 \uc785\ub825\ud558\uc138\uc694"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Exempted App \u2014 disable completely"

    const-string v1, "\uc608\uc678 \uc571 \u2014 \uc644\uc804\ud788 \uc0ac\uc6a9 \uc548 \ud568"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Expand / collapse log"

    const-string v1, "\ub85c\uadf8 \ud3bc\uce58\uae30 / \uc811\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Expanded KonaBess profile exceeds 32 KiB"

    const-string v1, "\ud480\uc5b4\ub0b8 KonaBess \ud504\ub85c\ud544\uc774 32 KiB\ub97c \ub118\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Expected 2\u201315 power levels per table"

    const-string v1, "\ud45c\ub9c8\ub2e4 2\u201315\uac1c\uc758 \uc804\ub825 \ub2e8\uacc4\uac00 \ud544\uc694\ud569\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Expected GPU tables 0 then 1"

    const-string v1, "GPU \ud45c 0, 1 \uc21c\uc11c\uac00 \ud544\uc694\ud569\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Expected both Samsung GPU tables"

    const-string v1, "\uc0bc\uc131 GPU \ud45c \ub450 \uac1c\uac00 \ubaa8\ub450 \ud544\uc694\ud569\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Expected one JSON profile"

    const-string v1, "JSON \ud504\ub85c\ud544 \ud558\ub098\uac00 \ud544\uc694\ud569\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Explain setup results with AI"

    const-string v1, "AI\ub85c \uc124\uc815 \uacb0\uacfc \uc124\uba85"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Export a shareable JSON file with frequencies and voltage levels"

    const-string v1, "\uc8fc\ud30c\uc218\uc640 \uc804\uc555 \ub2e8\uacc4\ub97c \ub2f4\uc740 \uacf5\uc720\uc6a9 JSON \ud30c\uc77c \ub0b4\ubcf4\ub0b4\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Failed: "

    const-string v1, "\uc2e4\ud328: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "File exceeds "

    const-string v1, "\ud30c\uc77c \ud06c\uae30 \ucd08\uacfc: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "File imported. Review crash details before analysis."

    const-string v1, "\ud30c\uc77c\uc744 \uac00\uc838\uc654\uc2b5\ub2c8\ub2e4. \ubd84\uc11d \uc804\uc5d0 \ud06c\ub798\uc2dc \uc815\ubcf4\ub97c \ud655\uc778\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "File loaded. Review the selected section; other sections are not sent. Redaction can miss sensitive information."

    const-string v1, "\ud30c\uc77c\uc744 \ubd88\ub7ec\uc654\uc2b5\ub2c8\ub2e4. \uc120\ud0dd\ud55c \uad6c\uac04\uc744 \ud655\uc778\ud558\uc138\uc694. \ub2e4\ub978 \uad6c\uac04\uc740 \ubcf4\ub0b4\uc9c0 \uc54a\uc2b5\ub2c8\ub2e4. \uac00\ub9ac\uae30 \ucc98\ub9ac\uc5d0\uc11c \ubbfc\uac10\ud55c \uc815\ubcf4\uac00 \ube60\uc9c8 \uc218 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Filter by feature name, attribute, or value."

    const-string v1, "\uae30\ub2a5 \uc774\ub984, \uc18d\uc131, \uac12\uc73c\ub85c \uac70\ub974\uae30."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Filtering: "

    const-string v1, "\ud544\ud130: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Find system crashes, app crashes and apps that fail to open. Uses your active AI backend."

    const-string v1, "\uc2dc\uc2a4\ud15c \ud06c\ub798\uc2dc, \uc571 \ud06c\ub798\uc2dc, \uc2e4\ud589\ub418\uc9c0 \uc54a\ub294 \uc571\uc744 \ucc3e\uc2b5\ub2c8\ub2e4. \ud65c\uc131 AI \ubc31\uc5d4\ub4dc\ub97c \uc0ac\uc6a9\ud569\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Finding crashes and app failures\u2026"

    const-string v1, "\ud06c\ub798\uc2dc\uc640 \uc571 \uc624\ub958\ub97c \ucc3e\ub294 \uc911\u2026"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Found "

    const-string v1, "\ubc1c\uacac: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Freezing eligible cached apps reduces their CPU activity. Device default preserves Android\'s policy; changes may need a reboot."

    const-string v1, "\ub300\uc0c1 \uce90\uc2dc \uc571\uc744 \ub3d9\uacb0\ud558\uba74 CPU \ud65c\ub3d9\uc774 \uc904\uc5b4\ub4ed\ub2c8\ub2e4. \uae30\uae30 \uae30\ubcf8\uac12\uc740 Android \uc815\ucc45\uc744 \uc720\uc9c0\ud558\uba70, \ubcc0\uacbd \uc2dc \uc7ac\ubd80\ud305\uc774 \ud544\uc694\ud560 \uc218 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Frequency floor \u00b7 "

    const-string v1, "\ucd5c\uc800 \uc8fc\ud30c\uc218 \u00b7 "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Full-Hz frequencies \u00b7 RPMh requests \u00b7 bus and ACD"

    const-string v1, "Hz \ub2e8\uc704 \uc8fc\ud30c\uc218 \u00b7 RPMh \uc694\uccad \u00b7 \ubc84\uc2a4 \ubc0f ACD"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "History and restoration"

    const-string v1, "\uae30\ub85d \ubc0f \ubcf5\uc6d0"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Import log file"

    const-string v1, "\ub85c\uadf8 \ud30c\uc77c \uac00\uc838\uc624\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Import profile"

    const-string v1, "\ud504\ub85c\ud544 \uac00\uc838\uc624\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Imported file (device provenance unverified)"

    const-string v1, "\uac00\uc838\uc628 \ud30c\uc77c (\uae30\uae30 \ucd9c\ucc98 \ubbf8\ud655\uc778)"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Imported profile saved. Loading did not write vendor_boot. Review before Apply."

    const-string v1, "\uac00\uc838\uc628 \ud504\ub85c\ud544\uc744 \uc800\uc7a5\ud588\uc2b5\ub2c8\ub2e4. \ubd88\ub7ec\uc624\uae30\ub9cc\uc73c\ub85c\ub294 vendor_boot\uc5d0 \uc4f0\uc9c0 \uc54a\uc2b5\ub2c8\ub2e4. \uc801\uc6a9 \uc804\uc5d0 \ud655\uc778\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Imported text file (device provenance unverified)"

    const-string v1, "\uac00\uc838\uc628 \ud14d\uc2a4\ud2b8 \ud30c\uc77c (\uae30\uae30 \ucd9c\ucc98 \ubbf8\ud655\uc778)"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Include log section "

    const-string v1, "\ub85c\uadf8 \uad6c\uac04 \ud3ec\ud568 "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Include this log section in the next message"

    const-string v1, "\ub2e4\uc74c \uba54\uc2dc\uc9c0\uc5d0 \uc774 \ub85c\uadf8 \uad6c\uac04 \ud3ec\ud568"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Initial minimum level"

    const-string v1, "\ucd08\uae30 \ucd5c\uc18c \ub2e8\uacc4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Install the updated ROM AI backend to enable chat"

    const-string v1, "\ub300\ud654\ub97c \uc4f0\ub824\uba74 \ucd5c\uc2e0 \ub86c\uc758 AI \ubc31\uc5d4\ub4dc\ub97c \uc124\uce58\ud558\uc138\uc694"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private static fill4(Ljava/util/HashMap;)V
    .locals 2

    const-string v0, "Invalid DNS provider hostname"

    const-string v1, "\uc798\ubabb\ub41c DNS \uc81c\uacf5\uc790 \ud638\uc2a4\ud2b8 \uc774\ub984"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Invalid GPU request"

    const-string v1, "\uc798\ubabb\ub41c GPU \uc694\uccad"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Invalid KonaBess Base64 data"

    const-string v1, "\uc798\ubabb\ub41c KonaBess Base64 \ub370\uc774\ud130"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Invalid KonaBess description"

    const-string v1, "\uc798\ubabb\ub41c KonaBess \uc124\uba85"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Invalid PIF toggle. "

    const-string v1, "\uc798\ubabb\ub41c PIF \uc2a4\uc704\uce58. "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Invalid Wi-Fi Calling value"

    const-string v1, "\uc798\ubabb\ub41c Wi-Fi \ud1b5\ud654 \uac12"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Invalid device-tree cell"

    const-string v1, "\uc798\ubabb\ub41c \ub514\ubc14\uc774\uc2a4 \ud2b8\ub9ac \uc140"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Invalid device-tree suffix"

    const-string v1, "\uc798\ubabb\ub41c \ub514\ubc14\uc774\uc2a4 \ud2b8\ub9ac \uc811\ubbf8\uc0ac"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Invalid enable switch"

    const-string v1, "\uc798\ubabb\ub41c \uc0ac\uc6a9 \uc2a4\uc704\uce58"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Invalid fingerprint structure or size. "

    const-string v1, "\ud551\uac70\ud504\ub9b0\ud2b8 \uad6c\uc870\ub098 \ud06c\uae30\uac00 \uc798\ubabb\ub418\uc5c8\uc2b5\ub2c8\ub2e4. "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Invalid first API level. "

    const-string v1, "\uccab API \ub808\ubca8\uc774 \uc798\ubabb\ub418\uc5c8\uc2b5\ub2c8\ub2e4. "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Invalid kernel control"

    const-string v1, "\uc798\ubabb\ub41c \ucee4\ub110 \ud56d\ubaa9"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Invalid kernel operation"

    const-string v1, "\uc798\ubabb\ub41c \ucee4\ub110 \uc791\uc5c5"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Invalid kernel value"

    const-string v1, "\uc798\ubabb\ub41c \ucee4\ub110 \uac12"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Invalid module identity"

    const-string v1, "\uc798\ubabb\ub41c \ubaa8\ub4c8 \uc815\ubcf4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Invalid operation"

    const-string v1, "\uc798\ubabb\ub41c \uc791\uc5c5"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Invalid package name"

    const-string v1, "\uc798\ubabb\ub41c \ud328\ud0a4\uc9c0 \uc774\ub984"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Invalid preset"

    const-string v1, "\uc798\ubabb\ub41c \ud504\ub9ac\uc14b"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Invalid saved app enabled state"

    const-string v1, "\uc800\uc7a5\ub41c \uc571 \uc0ac\uc6a9 \uc0c1\ud0dc\uac00 \uc798\ubabb\ub418\uc5c8\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Invalid security patch date. "

    const-string v1, "\ubcf4\uc548 \ud328\uce58 \ub0a0\uc9dc\uac00 \uc798\ubabb\ub418\uc5c8\uc2b5\ub2c8\ub2e4. "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Invalid standby bucket"

    const-string v1, "\uc798\ubabb\ub41c \ub300\uae30 \ubc84\ud0b7"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Invert activity protection for"

    const-string v1, "\uc561\ud2f0\ube44\ud2f0 \ubcf4\ud638 \ubc18\uc804 \ub300\uc0c1"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Keep enabled"

    const-string v1, "\uacc4\uc18d \uc0ac\uc6a9"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Keep mobile data active on Wi-Fi"

    const-string v1, "Wi-Fi \uc0ac\uc6a9 \uc911\uc5d0\ub3c4 \ubaa8\ubc14\uc77c \ub370\uc774\ud130 \uc720\uc9c0"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Keep original"

    const-string v1, "\uc6d0\ub798\ub300\ub85c \uc720\uc9c0"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Keep the AdGuard Intermediate CA in the Android user store; import the Personal CA here"

    const-string v1, "AdGuard Intermediate CA\ub294 Android \uc0ac\uc6a9\uc790 \uc800\uc7a5\uc18c\uc5d0 \ub450\uace0, Personal CA\ub294 \uc5ec\uae30\uc11c \uac00\uc838\uc624\uc138\uc694"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Keep the label under 61 characters"

    const-string v1, "\uc774\ub984\uc740 61\uc790 \ubbf8\ub9cc\uc73c\ub85c \uc785\ub825\ud558\uc138\uc694"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Kept enabled: "

    const-string v1, "\uacc4\uc18d \uc0ac\uc6a9 \uc911: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "KonaBess SKU selection differs from this Samsung firmware"

    const-string v1, "KonaBess SKU \uc120\ud0dd\uc774 \uc774 \uc0bc\uc131 \ud38c\uc6e8\uc5b4\uc640 \ub2e4\ub985\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Manual brightness"

    const-string v1, "\uc218\ub3d9 \ubc1d\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Manual mode prevents automatic brightness increases. Review brightness before going outdoors."

    const-string v1, "\uc218\ub3d9 \ubaa8\ub4dc\uc5d0\uc11c\ub294 \ubc1d\uae30\uac00 \uc790\ub3d9\uc73c\ub85c \uc62c\ub77c\uac00\uc9c0 \uc54a\uc2b5\ub2c8\ub2e4. \uc57c\uc678\uc5d0 \ub098\uac00\uae30 \uc804\uc5d0 \ubc1d\uae30\ub97c \ud655\uc778\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Maximum of 64 imported CAs reached"

    const-string v1, "\uac00\uc838\uc628 CA\uac00 \ucd5c\ub300 64\uac1c\uc5d0 \ub3c4\ub2ec\ud588\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Message and log exceed this backend\'s budget. Shorten the question or log section."

    const-string v1, "\uba54\uc2dc\uc9c0\uc640 \ub85c\uadf8\uac00 \uc774 \ubc31\uc5d4\ub4dc\uc758 \ud55c\ub3c4\ub97c \ub118\uc2b5\ub2c8\ub2e4. \uc9c8\ubb38\uc774\ub098 \ub85c\uadf8 \uad6c\uac04\uc744 \uc904\uc774\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Min starts at 70% transparency. Middle is 85%. Max makes it fully transparent."

    const-string v1, "\ucd5c\uc18c\ub294 \ud22c\uba85\ub3c4 70%, \uc911\uac04\uc740 85%, \ucd5c\ub300\ub294 \uc644\uc804\ud788 \ud22c\uba85\ud569\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Minimum refresh rate"

    const-string v1, "\ucd5c\uc18c \uc8fc\uc0ac\uc728"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Missing KonaBess frequency table"

    const-string v1, "KonaBess \uc8fc\ud30c\uc218 \ud45c\uac00 \uc5c6\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Module action verified. Restart required."

    const-string v1, "\ubaa8\ub4c8 \uc791\uc5c5\uc744 \ud655\uc778\ud588\uc2b5\ub2c8\ub2e4. \uc7ac\uc2dc\uc791\uc774 \ud544\uc694\ud569\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Module service did not respond. Scan again before retrying."

    const-string v1, "\ubaa8\ub4c8 \uc11c\ube44\uc2a4\uac00 \uc751\ub2f5\ud558\uc9c0 \uc54a\uc558\uc2b5\ub2c8\ub2e4. \ub2e4\uc2dc \uac80\uc0ac\ud55c \ub4a4 \uc2dc\ub3c4\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "More caching can avoid costly app reloads. Fewer cached processes is not inherently more efficient. Adjustable range: 32\u20134096."

    const-string v1, "\uce90\uc2dc\ub97c \ub298\ub9ac\uba74 \ube44\uc6a9\uc774 \ud070 \uc571 \uc7ac\ub85c\ub4dc\ub97c \uc904\uc77c \uc218 \uc788\uc2b5\ub2c8\ub2e4. \uce90\uc2dc \ud504\ub85c\uc138\uc2a4\uac00 \uc801\ub2e4\uace0 \ub354 \ud6a8\uc728\uc801\uc778 \uac83\uc740 \uc544\ub2d9\ub2c8\ub2e4. \uc870\uc808 \ubc94\uc704: 32\u20134096."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Native crash"

    const-string v1, "\ub124\uc774\ud2f0\ube0c \ud06c\ub798\uc2dc"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "New message"

    const-string v1, "\uc0c8 \uba54\uc2dc\uc9c0"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Next section"

    const-string v1, "\ub2e4\uc74c \uad6c\uac04"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "No GPU changes selected."

    const-string v1, "\uc120\ud0dd\ud55c GPU \ubcc0\uacbd \uc0ac\ud56d\uc774 \uc5c6\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "No actions recorded."

    const-string v1, "\uae30\ub85d\ub41c \uc791\uc5c5\uc774 \uc5c6\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "No analysis returned"

    const-string v1, "\ubd84\uc11d \uacb0\uacfc\uac00 \uc5c6\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "No answer returned"

    const-string v1, "\ub2f5\ubcc0\uc774 \uc5c6\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "No automatic app restrictions"

    const-string v1, "\uc790\ub3d9 \uc571 \uc81c\ud55c \uc5c6\uc74c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "No confirmed LSPosed conflicts found. This does not establish compatibility with every module."

    const-string v1, "\ud655\uc778\ub41c LSPosed \ucda9\ub3cc\uc774 \uc5c6\uc2b5\ub2c8\ub2e4. \ubaa8\ub4e0 \ubaa8\ub4c8\uacfc \ud638\ud658\ub41c\ub2e4\ub294 \ub73b\uc740 \uc544\ub2d9\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "No document picker available"

    const-string v1, "\ubb38\uc11c \uc120\ud0dd\uae30\ub97c \uc0ac\uc6a9\ud560 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "No document picker available."

    const-string v1, "\ubb38\uc11c \uc120\ud0dd\uae30\ub97c \uc0ac\uc6a9\ud560 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "No installed app supports this action"

    const-string v1, "\uc774 \uc791\uc5c5\uc744 \uc9c0\uc6d0\ud558\ub294 \uc571\uc774 \uc124\uce58\ub418\uc5b4 \uc788\uc9c0 \uc54a\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "No known conflict detected"

    const-string v1, "\uc54c\ub824\uc9c4 \ucda9\ub3cc \uc5c6\uc74c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "No known duplicate features found among enabled modules with matching scopes. Unlisted modules remain unchecked."

    const-string v1, "\ubc94\uc704\uac00 \uc77c\uce58\ud558\ub294 \ud65c\uc131 \ubaa8\ub4c8 \uc911 \uc54c\ub824\uc9c4 \uc911\ubcf5 \uae30\ub2a5\uc774 \uc5c6\uc2b5\ub2c8\ub2e4. \ubaa9\ub85d\uc5d0 \uc5c6\ub294 \ubaa8\ub4c8\uc740 \ud655\uc778\ud558\uc9c0 \uc54a\uc558\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "No log attached"

    const-string v1, "\ucca8\ubd80\ub41c \ub85c\uadf8 \uc5c6\uc74c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "No log attached. You can also paste directly below."

    const-string v1, "\ucca8\ubd80\ub41c \ub85c\uadf8\uac00 \uc5c6\uc2b5\ub2c8\ub2e4. \uc544\ub798\uc5d0 \uc9c1\uc811 \ubd99\uc5ec\ub123\uc5b4\ub3c4 \ub429\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "No matching apps"

    const-string v1, "\uc77c\uce58\ud558\ub294 \uc571 \uc5c6\uc74c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "No modules listed. Check scan coverage above if root access was unavailable."

    const-string v1, "\ud45c\uc2dc\ud560 \ubaa8\ub4c8\uc774 \uc5c6\uc2b5\ub2c8\ub2e4. \ub8e8\ud2b8 \uad8c\ud55c\uc744 \uc4f8 \uc218 \uc5c6\uc5c8\ub2e4\uba74 \uc704\uc758 \uac80\uc0ac \ubc94\uc704\ub97c \ud655\uc778\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "No system crash, app crash, app-start failure or app-not-responding report found. Nothing was sent for analysis."

    const-string v1, "\uc2dc\uc2a4\ud15c \ud06c\ub798\uc2dc, \uc571 \ud06c\ub798\uc2dc, \uc571 \uc2e4\ud589 \uc2e4\ud328, \uc571 \uc751\ub2f5 \uc5c6\uc74c \uae30\ub85d\uc774 \uc5c6\uc2b5\ub2c8\ub2e4. \ubd84\uc11d\uc744 \uc704\ud574 \ubcf4\ub0b8 \ub0b4\uc6a9\uc740 \uc5c6\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Non-contiguous KonaBess GPU index"

    const-string v1, "KonaBess GPU \uc778\ub371\uc2a4\uac00 \uc5f0\uc18d\ub418\uc9c0 \uc54a\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Not analyzed: "

    const-string v1, "\ubd84\uc11d \uc548 \ub428: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Not scanned"

    const-string v1, "\uac80\uc0ac \uc548 \ud568"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Not verified \u2014 PIF is switched off."

    const-string v1, "\ud655\uc778 \uc548 \ub428 \u2014 PIF\uac00 \uaebc\uc838 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Not verified \u2014 PIF properties could not be read."

    const-string v1, "\ud655\uc778 \uc548 \ub428 \u2014 PIF \uc18d\uc131\uc744 \uc77d\uc744 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Not verified \u2014 TEE is switched off; this is not a configuration failure."

    const-string v1, "\ud655\uc778 \uc548 \ub428 \u2014 TEE\uac00 \uaebc\uc838 \uc788\uc2b5\ub2c8\ub2e4. \uc124\uc815 \uc624\ub958\ub294 \uc544\ub2d9\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Not verified \u2014 built-in PIF class is unavailable."

    const-string v1, "\ud655\uc778 \uc548 \ub428 \u2014 \ub0b4\uc7a5 PIF \ud074\ub798\uc2a4\ub97c \uc0ac\uc6a9\ud560 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Not verified \u2014 no fresh backend heartbeat. Check Manage Keybox \u2192 System and collect logs after reproducing the problem."

    const-string v1, "\ud655\uc778 \uc548 \ub428 \u2014 \ubc31\uc5d4\ub4dc\uc758 \ucd5c\uc2e0 \uc751\ub2f5 \uc2e0\ud638\uac00 \uc5c6\uc2b5\ub2c8\ub2e4. \ud0a4\ubc15\uc2a4 \uad00\ub9ac \u2192 \uc2dc\uc2a4\ud15c\uc744 \ud655\uc778\ud558\uace0, \ubb38\uc81c\ub97c \uc7ac\ud604\ud55c \ub4a4 \ub85c\uadf8\ub97c \uc218\uc9d1\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Not verified \u2014 no matching GMS initialization evidence in the recent log buffer. Missing logs do not prove failure."

    const-string v1, "\ud655\uc778 \uc548 \ub428 \u2014 \ucd5c\uadfc \ub85c\uadf8 \ubc84\ud37c\uc5d0 \ud574\ub2f9\ud558\ub294 GMS \ucd08\uae30\ud654 \uae30\ub85d\uc774 \uc5c6\uc2b5\ub2c8\ub2e4. \ub85c\uadf8\uac00 \uc5c6\ub2e4\uace0 \uc2e4\ud328\ud55c \uac83\uc740 \uc544\ub2d9\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Not verified \u2014 no profile targets any app. Review target apps in Manage Keybox \u2192 Profiles."

    const-string v1, "\ud655\uc778 \uc548 \ub428 \u2014 \ub300\uc0c1 \uc571\uc774 \uc9c0\uc815\ub41c \ud504\ub85c\ud544\uc774 \uc5c6\uc2b5\ub2c8\ub2e4. \ud0a4\ubc15\uc2a4 \uad00\ub9ac \u2192 \ud504\ub85c\ud544\uc5d0\uc11c \ub300\uc0c1 \uc571\uc744 \ud655\uc778\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Not verified \u2014 profile or keybox settings could not be read."

    const-string v1, "\ud655\uc778 \uc548 \ub428 \u2014 \ud504\ub85c\ud544\uc774\ub098 \ud0a4\ubc15\uc2a4 \uc124\uc815\uc744 \uc77d\uc744 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Not verified \u2014 recent device logs are unavailable."

    const-string v1, "\ud655\uc778 \uc548 \ub428 \u2014 \ucd5c\uadfc \uae30\uae30 \ub85c\uadf8\ub97c \uc0ac\uc6a9\ud560 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Not verified \u2014 successful GMS unstable-process initialization was observed in the recent buffer. This is historical evidence, not proof that the current process uses the current settings or that Google accepts it."

    const-string v1, "\ud655\uc778 \uc548 \ub428 \u2014 \ucd5c\uadfc \ubc84\ud37c\uc5d0\uc11c GMS unstable \ud504\ub85c\uc138\uc2a4\uac00 \uc815\uc0c1 \ucd08\uae30\ud654\ub41c \uae30\ub85d\uc744 \ucc3e\uc558\uc2b5\ub2c8\ub2e4. \uacfc\uac70 \uae30\ub85d\uc77c \ubfd0\uc774\uba70, \ud604\uc7ac \ud504\ub85c\uc138\uc2a4\uac00 \uc9c0\uae08 \uc124\uc815\uc744 \uc4f0\uace0 \uc788\ub2e4\uac70\ub098 Google\uc774 \uc774\ub97c \ubc1b\uc544\ub4e4\uc778\ub2e4\ub294 \uc99d\uac70\ub294 \uc544\ub2d9\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Not verified \u2014 the compatible keybox/profile validator is unavailable."

    const-string v1, "\ud655\uc778 \uc548 \ub428 \u2014 \ud638\ud658\ub418\ub294 \ud0a4\ubc15\uc2a4/\ud504\ub85c\ud544 \uac80\uc0ac\uae30\ub97c \uc0ac\uc6a9\ud560 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Off avoids ambient display activity."

    const-string v1, "\ub044\uba74 \uc570\ube44\uc5b8\ud2b8 \ub514\uc2a4\ud50c\ub808\uc774 \ub3d9\uc791\uc744 \ub9c9\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Off disables carrier Wi-Fi Calling for this subscription, not ordinary Wi-Fi data. Calls can fail with poor cellular coverage. Carrier policy may reject the change."

    const-string v1, "\ub044\uba74 \uc774 \ud68c\uc120\uc758 \ud1b5\uc2e0\uc0ac Wi-Fi \ud1b5\ud654\uac00 \uaebc\uc9d1\ub2c8\ub2e4. \uc77c\ubc18 Wi-Fi \ub370\uc774\ud130\ub294 \uadf8\ub300\ub85c\uc785\ub2c8\ub2e4. \uc140\ub8f0\ub7ec \uc2e0\ud638\uac00 \uc57d\ud558\uba74 \ud1b5\ud654\uac00 \uc2e4\ud328\ud560 \uc218 \uc788\uace0, \ud1b5\uc2e0\uc0ac \uc815\ucc45\uc774 \ubcc0\uacbd\uc744 \uac70\ubd80\ud560 \uc218 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Off disconnects ALL Wi-Fi, including foreground traffic and Wi-Fi Calling. Mobile data may take over and use more power/data. For no scanning while off, also disable Wi-Fi scanning."

    const-string v1, "\ub044\uba74 \uc0ac\uc6a9 \uc911\uc778 \ud1b5\uc2e0\uacfc Wi-Fi \ud1b5\ud654\ub97c \ud3ec\ud568\ud574 \ubaa8\ub4e0 Wi-Fi\uac00 \ub04a\uae41\ub2c8\ub2e4. \ubaa8\ubc14\uc77c \ub370\uc774\ud130\ub85c \ub118\uc5b4\uac00 \uc804\ub825\uacfc \ub370\uc774\ud130\ub97c \ub354 \uc4f8 \uc218 \uc788\uc2b5\ub2c8\ub2e4. \uaebc\uc9c4 \ub3d9\uc548 \uac80\uc0c9\ub3c4 \ub9c9\uc73c\ub824\uba74 Wi-Fi \uac80\uc0c9\ub3c4 \ub044\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Off reduces simultaneous data connectivity; Wi-Fi-to-mobile handover can be slower."

    const-string v1, "\ub044\uba74 \ub3d9\uc2dc \ub370\uc774\ud130 \uc5f0\uacb0\uc774 \uc904\uc5b4 Wi-Fi\uc5d0\uc11c \ubaa8\ubc14\uc77c \ub370\uc774\ud130\ub85c \ub118\uc5b4\uac00\ub294 \uc18d\ub3c4\uac00 \ub290\ub824\uc9c8 \uc218 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Off stops Android sync adapters. Apps with their own network schedulers require background restrictions too."

    const-string v1, "\ub044\uba74 Android \ub3d9\uae30\ud654 \uc5b4\ub311\ud130\uac00 \uba48\ucda5\ub2c8\ub2e4. \uc790\uccb4 \ub124\ud2b8\uc6cc\ud06c \uc2a4\ucf00\uc904\ub7ec\uac00 \uc788\ub294 \uc571\uc740 \ubc31\uadf8\ub77c\uc6b4\ub4dc \uc81c\ud55c\ub3c4 \ud568\uaed8 \ud544\uc694\ud569\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "On \u00b7 Custom provider"

    const-string v1, "\ucf1c\uc9d0 \u00b7 \uc0ac\uc6a9\uc790 \uc9c0\uc815 \uc81c\uacf5\uc790"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "On device \u2014 "

    const-string v1, "\uae30\uae30 \u2014 "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Online \u2014 "

    const-string v1, "\uc628\ub77c\uc778 \u2014 "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Only after Apply or Restore reports success"

    const-string v1, "\uc801\uc6a9 \ub610\ub294 \ubcf5\uc6d0\uc774 \uc131\uacf5\ud55c \ub4a4\uc5d0\ub9cc"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Only owner Settings may apply battery profiles"

    const-string v1, "\uc18c\uc720\uc790 \uc124\uc815\uc5d0\uc11c\ub9cc \ubc30\ud130\ub9ac \ud504\ub85c\ud544\uc744 \uc801\uc6a9\ud560 \uc218 \uc788\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Open LSPosed Manager from its notification or shortcut, disable the module/scope, then restart. No compatible manager launch activity was found."

    const-string v1, "\uc54c\ub9bc\uc774\ub098 \ubc14\ub85c\uac00\uae30\ub85c LSPosed \uad00\ub9ac\uc790\ub97c \uc5f4\uace0 \ubaa8\ub4c8/\ubc94\uc704\ub97c \ub048 \ub4a4 \uc7ac\uc2dc\uc791\ud558\uc138\uc694. \ud638\ud658\ub418\ub294 \uad00\ub9ac\uc790 \uc2e4\ud589 \ud654\uba74\uc744 \ucc3e\uc9c0 \ubabb\ud588\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Open app"

    const-string v1, "\uc571 \uc5f4\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Open local name values"

    const-string v1, "\ub85c\uceec \uc774\ub984 \uac12 \uc5f4\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Open manager"

    const-string v1, "\uad00\ub9ac\uc790 \uc5f4\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Optional. Lower refresh rates trade smoothness for lower display/rendering power. Samsung\'s display policy may override this request."

    const-string v1, "\uc120\ud0dd \uc0ac\ud56d. \uc8fc\uc0ac\uc728\uc744 \ub0ae\ucd94\uba74 \ubd80\ub4dc\ub7ec\uc6c0 \ub300\uc2e0 \ud654\uba74/\ub80c\ub354\ub9c1 \uc804\ub825\uc744 \uc544\ub08d\ub2c8\ub2e4. \uc0bc\uc131 \ub514\uc2a4\ud50c\ub808\uc774 \uc815\ucc45\uc774 \uc774 \uc694\uccad\ubcf4\ub2e4 \uc6b0\uc120\ud560 \uc218 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Original image saved"

    const-string v1, "\uc6d0\ubcf8 \uc774\ubbf8\uc9c0 \uc800\uc7a5\ub428"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Original log saved. It may contain sensitive information."

    const-string v1, "\uc6d0\ubcf8 \ub85c\uadf8\ub97c \uc800\uc7a5\ud588\uc2b5\ub2c8\ub2e4. \ubbfc\uac10\ud55c \uc815\ubcf4\uac00 \ub4e4\uc5b4 \uc788\uc744 \uc218 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Original vendor_boot restored and verified. Reboot when ready."

    const-string v1, "\uc6d0\ubcf8 vendor_boot\ub97c \ubcf5\uc6d0\ud558\uace0 \uac80\uc99d\ud588\uc2b5\ub2c8\ub2e4. \uc900\ube44\ub418\uba74 \uc7ac\ubd80\ud305\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Other sections have not been analyzed."

    const-string v1, "\ub2e4\ub978 \uad6c\uac04\uc740 \ubd84\uc11d\ud558\uc9c0 \uc54a\uc558\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Oversized GPU response"

    const-string v1, "GPU \uc751\ub2f5\uc774 \ub108\ubb34 \ud07d\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Oversized rollback ZIP"

    const-string v1, "\ub864\ubc31 ZIP\uc774 \ub108\ubb34 \ud07d\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Oversized saved ZIP"

    const-string v1, "\uc800\uc7a5\ub41c ZIP\uc774 \ub108\ubb34 \ud07d\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Paste log"

    const-string v1, "\ub85c\uadf8 \ubd99\uc5ec\ub123\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Pasted log"

    const-string v1, "\ubd99\uc5ec\ub123\uc740 \ub85c\uadf8"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Pasted log exceeds 256 KiB of characters. Use a smaller excerpt."

    const-string v1, "\ubd99\uc5ec\ub123\uc740 \ub85c\uadf8\uac00 256 KiB\ub97c \ub118\uc2b5\ub2c8\ub2e4. \ub354 \uc9e7\uac8c \uc798\ub77c\uc11c \ub123\uc73c\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Pending removal"

    const-string v1, "\uc81c\uac70 \ub300\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Permissions to remove"

    const-string v1, "\uc81c\uac70\ud560 \uad8c\ud55c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Policy request failed"

    const-string v1, "\uc815\ucc45 \uc694\uccad \uc2e4\ud328"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "PortROM audio: restart to apply"

    const-string v1, "PortROM \uc624\ub514\uc624: \uc7ac\uc2dc\uc791\ud574\uc57c \uc801\uc6a9\ub429\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Power service unavailable"

    const-string v1, "\uc804\uc6d0 \uc11c\ube44\uc2a4\ub97c \uc0ac\uc6a9\ud560 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Power-saving states may reduce link consumption. Performance disables them; aggressive savings can expose driver instability."

    const-string v1, "\uc808\uc804 \uc0c1\ud0dc\ub97c \uc4f0\uba74 \uc5f0\uacb0 \uc804\ub825 \uc18c\ubaa8\uac00 \uc904 \uc218 \uc788\uc2b5\ub2c8\ub2e4. \uc131\ub2a5 \ubaa8\ub4dc\ub294 \uc774\ub97c \ub044\uba70, \uac15\ud55c \uc808\uc57d\uc740 \ub4dc\ub77c\uc774\ubc84 \ubd88\uc548\uc815\uc744 \uc77c\uc73c\ud0ac \uc218 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Prepare the selected model or provider in AI Settings first"

    const-string v1, "\uba3c\uc800 AI \uc124\uc815\uc5d0\uc11c \uc120\ud0dd\ud55c \ubaa8\ub378\uc774\ub098 \uc81c\uacf5\uc790\ub97c \uc900\ube44\ud558\uc138\uc694"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Preparing setup report for review\u2026"

    const-string v1, "\uac80\ud1a0\ud560 \uc124\uc815 \ubcf4\uace0\uc11c\ub97c \uc900\ube44\ud558\ub294 \uc911\u2026"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Preset selected. Review the controls, then Save and apply."

    const-string v1, "\ud504\ub9ac\uc14b\uc744 \uc120\ud0dd\ud588\uc2b5\ub2c8\ub2e4. \ud56d\ubaa9\uc744 \ud655\uc778\ud55c \ub4a4 \uc800\uc7a5 \ubc0f \uc801\uc6a9\uc744 \ub204\ub974\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Prevent Play Store update"

    const-string v1, "Play \uc2a4\ud1a0\uc5b4 \uc5c5\ub370\uc774\ud2b8 \ub9c9\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Previous section"

    const-string v1, "\uc774\uc804 \uad6c\uac04"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Private DNS"

    const-string v1, "\uac1c\uc778 DNS"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Private DNS is restricted by your administrator"

    const-string v1, "\uad00\ub9ac\uc790\uac00 \uac1c\uc778 DNS\ub97c \uc81c\ud55c\ud588\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Problem found \u2014 "

    const-string v1, "\ubb38\uc81c \ubc1c\uacac \u2014 "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Problem found \u2014 a targeted keybox contains an expired or not-yet-valid certificate."

    const-string v1, "\ubb38\uc81c \ubc1c\uacac \u2014 \ub300\uc0c1 \ud0a4\ubc15\uc2a4\uc5d0 \ub9cc\ub8cc\ub418\uc5c8\uac70\ub098 \uc544\uc9c1 \uc720\ud6a8\ud558\uc9c0 \uc54a\uc740 \uc778\uc99d\uc11c\uac00 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Problem found \u2014 a targeted profile has no selected keybox. Select a keybox in Manage Keybox \u2192 Profiles."

    const-string v1, "\ubb38\uc81c \ubc1c\uacac \u2014 \ub300\uc0c1 \ud504\ub85c\ud544\uc5d0 \uc120\ud0dd\ub41c \ud0a4\ubc15\uc2a4\uac00 \uc5c6\uc2b5\ub2c8\ub2e4. \ud0a4\ubc15\uc2a4 \uad00\ub9ac \u2192 \ud504\ub85c\ud544\uc5d0\uc11c \ud0a4\ubc15\uc2a4\ub97c \uc120\ud0dd\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Problem found \u2014 a targeted profile uses an AOSP software test keybox; it is not a hardware attestation identity."

    const-string v1, "\ubb38\uc81c \ubc1c\uacac \u2014 \ub300\uc0c1 \ud504\ub85c\ud544\uc774 AOSP \uc18c\ud504\ud2b8\uc6e8\uc5b4 \ud14c\uc2a4\ud2b8 \ud0a4\ubc15\uc2a4\ub97c \uc501\ub2c8\ub2e4. \ud558\ub4dc\uc6e8\uc5b4 \uc778\uc99d \uc815\ubcf4\uac00 \uc544\ub2d9\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Problem found \u2014 live backend reports incomplete daemon/interceptor/configuration/keybox readiness. Check Manage Keybox \u2192 System."

    const-string v1, "\ubb38\uc81c \ubc1c\uacac \u2014 \ubc31\uc5d4\ub4dc\uac00 \ub370\ubaac/\uc778\ud130\uc149\ud130/\uc124\uc815/\ud0a4\ubc15\uc2a4 \uc900\ube44\uac00 \ub05d\ub098\uc9c0 \uc54a\uc558\ub2e4\uace0 \ubcf4\uace0\ud569\ub2c8\ub2e4. \ud0a4\ubc15\uc2a4 \uad00\ub9ac \u2192 \uc2dc\uc2a4\ud15c\uc744 \ud655\uc778\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Problem found \u2014 profile configuration exceeds its size limit."

    const-string v1, "\ubb38\uc81c \ubc1c\uacac \u2014 \ud504\ub85c\ud544 \uc124\uc815\uc774 \ud06c\uae30 \ud55c\ub3c4\ub97c \ub118\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Problem found \u2014 profile or selected keybox validation failed. Review profiles and keyboxes in Manage Keybox. No signing material was included in this report."

    const-string v1, "\ubb38\uc81c \ubc1c\uacac \u2014 \ud504\ub85c\ud544\uc774\ub098 \uc120\ud0dd\ud55c \ud0a4\ubc15\uc2a4 \uac80\uc99d\uc5d0 \uc2e4\ud328\ud588\uc2b5\ub2c8\ub2e4. \ud0a4\ubc15\uc2a4 \uad00\ub9ac\uc5d0\uc11c \ud504\ub85c\ud544\uacfc \ud0a4\ubc15\uc2a4\ub97c \ud655\uc778\ud558\uc138\uc694. \uc774 \ubcf4\uace0\uc11c\uc5d0\ub294 \uc11c\uba85 \uc815\ubcf4\uac00 \ud3ec\ud568\ub418\uc9c0 \uc54a\uc558\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Problem found \u2014 recent PIF log buffer contains startup/configuration failures. Reproduce with the affected app and collect device logs. Old errors can remain after a configuration change."

    const-string v1, "\ubb38\uc81c \ubc1c\uacac \u2014 \ucd5c\uadfc PIF \ub85c\uadf8 \ubc84\ud37c\uc5d0 \uc2dc\uc791/\uc124\uc815 \uc2e4\ud328 \uae30\ub85d\uc774 \uc788\uc2b5\ub2c8\ub2e4. \ubb38\uc81c\uac00 \uc0dd\uae30\ub294 \uc571\uc73c\ub85c \uc7ac\ud604\ud55c \ub4a4 \uae30\uae30 \ub85c\uadf8\ub97c \uc218\uc9d1\ud558\uc138\uc694. \uc124\uc815\uc744 \ubc14\uafbc \ub4a4\uc5d0\ub3c4 \uc608\uc804 \uc624\ub958\uac00 \ub0a8\uc544 \uc788\uc744 \uc218 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Profile JSON is too deeply nested"

    const-string v1, "\ud504\ub85c\ud544 JSON\uc758 \uc911\ucca9\uc774 \ub108\ubb34 \uae4a\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Profile backed up."

    const-string v1, "\ud504\ub85c\ud544\uc744 \ubc31\uc5c5\ud588\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Profile exceeds 32 KiB"

    const-string v1, "\ud504\ub85c\ud544\uc774 32 KiB\ub97c \ub118\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Profile exceeds 64 KB"

    const-string v1, "\ud504\ub85c\ud544\uc774 64 KB\ub97c \ub118\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Profile format or target GPU does not match this device"

    const-string v1, "\ud504\ub85c\ud544 \ud615\uc2dd\uc774\ub098 \ub300\uc0c1 GPU\uac00 \uc774 \uae30\uae30\uc640 \ub9de\uc9c0 \uc54a\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Profile must be 1\u201332768 bytes"

    const-string v1, "\ud504\ub85c\ud544\uc740 1\u201332768\ubc14\uc774\ud2b8\uc5ec\uc57c \ud569\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Profile unavailable"

    const-string v1, "\ud504\ub85c\ud544\uc744 \uc0ac\uc6a9\ud560 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Profile validated. Review before loading."

    const-string v1, "\ud504\ub85c\ud544 \uac80\uc99d \uc644\ub8cc. \ubd88\ub7ec\uc624\uae30 \uc804\uc5d0 \ud655\uc778\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Protected \u2014 needed for recovery"

    const-string v1, "\ubcf4\ud638\ub428 \u2014 \ubcf5\uad6c\uc5d0 \ud544\uc694"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Read recent logs from this device"

    const-string v1, "\uc774 \uae30\uae30\uc758 \ucd5c\uadfc \ub85c\uadf8 \uc77d\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Reading Exempted (5) apps\u2026"

    const-string v1, "\uc608\uc678(5) \uc571 \uc77d\ub294 \uc911\u2026"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Reading selected log\u2026"

    const-string v1, "\uc120\ud0dd\ud55c \ub85c\uadf8 \uc77d\ub294 \uc911\u2026"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Reading text file\u2026"

    const-string v1, "\ud14d\uc2a4\ud2b8 \ud30c\uc77c \uc77d\ub294 \uc911\u2026"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Reading tuning profile\u2026"

    const-string v1, "\ud29c\ub2dd \ud504\ub85c\ud544 \uc77d\ub294 \uc911\u2026"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Reboot now"

    const-string v1, "\uc9c0\uae08 \uc7ac\ubd80\ud305"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Recent log collected; older or persistent crash evidence may be absent."

    const-string v1, "\ucd5c\uadfc \ub85c\uadf8\ub97c \uc218\uc9d1\ud588\uc2b5\ub2c8\ub2e4. \uc624\ub798\ub418\uc5c8\uac70\ub098 \uc9c0\uc18d\ub41c \ud06c\ub798\uc2dc \uae30\ub85d\uc740 \ube60\uc838 \uc788\uc744 \uc218 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Record video"

    const-string v1, "\ub3d9\uc601\uc0c1 \ucd2c\uc601"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Recovery component or shared UID protected"

    const-string v1, "\ubcf5\uad6c \uad6c\uc131\uc694\uc18c \ub610\ub294 \uacf5\uc720 UID\ub77c \ubcf4\ud638\ub428"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Recovery instructions"

    const-string v1, "\ubcf5\uad6c \ubc29\ubc95"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Refresh AI backend"

    const-string v1, "AI \ubc31\uc5d4\ub4dc \uc0c8\ub85c\uace0\uce68"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Refresh compatibility before exporting the rollback ZIP."

    const-string v1, "\ub864\ubc31 ZIP\uc744 \ub0b4\ubcf4\ub0b4\uae30 \uc804\uc5d0 \ud638\ud658\uc131\uc744 \uc0c8\ub85c\uace0\uce68\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Refresh the AI backend first."

    const-string v1, "\uba3c\uc800 AI \ubc31\uc5d4\ub4dc\ub97c \uc0c8\ub85c\uace0\uce68\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Refresh the backend before sending"

    const-string v1, "\ubcf4\ub0b4\uae30 \uc804\uc5d0 \ubc31\uc5d4\ub4dc\ub97c \uc0c8\ub85c\uace0\uce68\ud558\uc138\uc694"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Refresh the backend before sending again."

    const-string v1, "\ub2e4\uc2dc \ubcf4\ub0b4\uae30 \uc804\uc5d0 \ubc31\uc5d4\ub4dc\ub97c \uc0c8\ub85c\uace0\uce68\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Refusing an unexpected marker file"

    const-string v1, "\uc608\uc0c1\ud558\uc9c0 \ubabb\ud55c \ud45c\uc2dc \ud30c\uc77c\uc774\ub77c \uac70\ubd80\ud569\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Remove log"

    const-string v1, "\ub85c\uadf8 \uc81c\uac70"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Remove power level"

    const-string v1, "\uc804\ub825 \ub2e8\uacc4 \uc81c\uac70"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Renumber remaining levels and adjust references"

    const-string v1, "\ub0a8\uc740 \ub2e8\uacc4 \ubc88\ud638\ub97c \ub2e4\uc2dc \ub9e4\uae30\uace0 \ucc38\uc870\ub97c \uc870\uc815"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Replace the saved draft with the current image\'s table"

    const-string v1, "\uc800\uc7a5\ub41c \ucd08\uc548\uc744 \ud604\uc7ac \uc774\ubbf8\uc9c0\uc758 \ud45c\ub85c \ubc14\uafb8\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Report ready. Review the selected sections before analysis."

    const-string v1, "\ubcf4\uace0\uc11c \uc900\ube44 \uc644\ub8cc. \ubd84\uc11d \uc804\uc5d0 \uc120\ud0dd\ud55c \uad6c\uac04\uc744 \ud655\uc778\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Request cancelled. Your draft and log remain available."

    const-string v1, "\uc694\uccad\uc744 \ucde8\uc18c\ud588\uc2b5\ub2c8\ub2e4. \uc791\uc131 \uc911\uc778 \ub0b4\uc6a9\uacfc \ub85c\uadf8\ub294 \uadf8\ub300\ub85c \ub0a8\uc544 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Requests Android\'s low-power policy. Charging or Samsung policy can switch it off."

    const-string v1, "Android \uc800\uc804\ub825 \uc815\ucc45\uc744 \uc694\uccad\ud569\ub2c8\ub2e4. \ucda9\uc804 \uc911\uc774\uac70\ub098 \uc0bc\uc131 \uc815\ucc45\uc5d0 \ub530\ub77c \uaebc\uc9c8 \uc218 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Required before Apply \u00b7 choose PC or USB storage"

    const-string v1, "\uc801\uc6a9 \uc804\uc5d0 \ud544\uc694 \u00b7 PC\ub098 USB \uc800\uc7a5\uc18c\ub97c \uc120\ud0dd\ud558\uc138\uc694"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Requires Developer options and Wi-Fi. Pair your computer in Wireless debugging settings first."

    const-string v1, "\uac1c\ubc1c\uc790 \uc635\uc158\uacfc Wi-Fi\uac00 \ud544\uc694\ud569\ub2c8\ub2e4. \uba3c\uc800 \ubb34\uc120 \ub514\ubc84\uae45 \uc124\uc815\uc5d0\uc11c \ucef4\ud4e8\ud130\ub97c \ud398\uc5b4\ub9c1\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Requires Developer options. Turning this off disconnects USB debugging."

    const-string v1, "\uac1c\ubc1c\uc790 \uc635\uc158\uc774 \ud544\uc694\ud569\ub2c8\ub2e4. \ub044\uba74 USB \ub514\ubc84\uae45 \uc5f0\uacb0\uc774 \ub04a\uae41\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restart SystemUI"

    const-string v1, "SystemUI \uc7ac\uc2dc\uc791"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restart after changing LSPosed scope"

    const-string v1, "LSPosed \ubc94\uc704\ub97c \ubc14\uafbc \ub4a4 \uc7ac\uc2dc\uc791"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restart backup for current ROM"

    const-string v1, "\ud604\uc7ac \ub86c \ubc31\uc5c5 \ub2e4\uc2dc \uc2dc\uc791"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restart device?"

    const-string v1, "\uae30\uae30\ub97c \uc7ac\uc2dc\uc791\ud560\uae4c\uc694?"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restart later"

    const-string v1, "\ub098\uc911\uc5d0 \uc7ac\uc2dc\uc791"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restart now"

    const-string v1, "\uc9c0\uae08 \uc7ac\uc2dc\uc791"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restart postponed. Changes are pending."

    const-string v1, "\uc7ac\uc2dc\uc791\uc744 \ubbf8\ub918\uc2b5\ub2c8\ub2e4. \ubcc0\uacbd \uc0ac\ud56d\uc774 \ub300\uae30 \uc911\uc785\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restart required"

    const-string v1, "\uc7ac\uc2dc\uc791 \ud544\uc694"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restart required. A loaded module can remain active until restart."

    const-string v1, "\uc7ac\uc2dc\uc791\uc774 \ud544\uc694\ud569\ub2c8\ub2e4. \uc774\ubbf8 \ubd88\ub7ec\uc628 \ubaa8\ub4c8\uc740 \uc7ac\uc2dc\uc791 \uc804\uae4c\uc9c0 \uacc4\uc18d \ub3d9\uc791\ud560 \uc218 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restart to apply the module change. Loaded hooks may still be active."

    const-string v1, "\ubaa8\ub4c8 \ubcc0\uacbd\uc744 \uc801\uc6a9\ud558\ub824\uba74 \uc7ac\uc2dc\uc791\ud558\uc138\uc694. \uc774\ubbf8 \uac78\ub9b0 \ud6c4\ud0b9\uc774 \uacc4\uc18d \ub3d9\uc791\ud560 \uc218 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restarts the status bar and Quick Settings. The screen may briefly go blank."

    const-string v1, "\uc0c1\ud0dc \ud45c\uc2dc\uc904\uacfc \ube60\ub978 \uc124\uc815\uc744 \ub2e4\uc2dc \uc2dc\uc791\ud569\ub2c8\ub2e4. \ud654\uba74\uc774 \uc7a0\uc2dc \uaebc\uc9c8 \uc218 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restoration help"

    const-string v1, "\ubcf5\uc6d0 \ub3c4\uc6c0\ub9d0"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restore original vendor_boot"

    const-string v1, "\uc6d0\ubcf8 vendor_boot \ubcf5\uc6d0"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restore removes only unchanged disable markers created by this menu. For recovery restoration, remove only the selected module\u2019s disable file whose contents start with \u2018UN1CA troubleshooting v1\u2019. Module files and app data are preserved."

    const-string v1, "\ubcf5\uc6d0\uc740 \uc774 \uba54\ub274\uac00 \ub9cc\ub4e0, \ubcc0\uacbd\ub418\uc9c0 \uc54a\uc740 \ube44\ud65c\uc131\ud654 \ud45c\uc2dc\ub9cc \uc9c0\uc6c1\ub2c8\ub2e4. \ub9ac\ucee4\ubc84\ub9ac\uc5d0\uc11c \ubcf5\uc6d0\ud558\ub824\uba74 \uc120\ud0dd\ud55c \ubaa8\ub4c8\uc758 disable \ud30c\uc77c \uc911 \ub0b4\uc6a9\uc774 \u2018UN1CA troubleshooting v1\u2019\ub85c \uc2dc\uc791\ud558\ub294 \uac83\ub9cc \uc9c0\uc6b0\uc138\uc694. \ubaa8\ub4c8 \ud30c\uc77c\uacfc \uc571 \ub370\uc774\ud130\ub294 \uadf8\ub300\ub85c \uc720\uc9c0\ub429\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restore the pre-trial image, then reboot"

    const-string v1, "\uc2dc\ud5d8 \uc804 \uc774\ubbf8\uc9c0\ub97c \ubcf5\uc6d0\ud55c \ub4a4 \uc7ac\ubd80\ud305"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restore this module by removing this menu\u2019s disable marker."

    const-string v1, "\uc774 \uba54\ub274\uc758 \ube44\ud65c\uc131\ud654 \ud45c\uc2dc\ub97c \uc9c0\uc6cc\uc11c \ubaa8\ub4c8\uc744 \ubcf5\uc6d0\ud569\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restore this module?"

    const-string v1, "\uc774 \ubaa8\ub4c8\uc744 \ubcf5\uc6d0\ud560\uae4c\uc694?"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restore through OrangeFox if Android cannot start"

    const-string v1, "Android\uac00 \uc2dc\uc791\ub418\uc9c0 \uc54a\uc73c\uba74 OrangeFox\ub85c \ubcf5\uc6d0"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restrict user and non-essential system apps"

    const-string v1, "\uc0ac\uc6a9\uc790 \uc571\uacfc \ud544\uc218\uac00 \uc544\ub2cc \uc2dc\uc2a4\ud15c \uc571 \uc81c\ud55c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restricts background data on metered networks; Wi-Fi is not necessarily metered."

    const-string v1, "\ub370\uc774\ud130 \uc694\uae08\uc774 \ubd80\uacfc\ub418\ub294 \ub124\ud2b8\uc6cc\ud06c\uc5d0\uc11c \ubc31\uadf8\ub77c\uc6b4\ub4dc \ub370\uc774\ud130\ub97c \uc81c\ud55c\ud569\ub2c8\ub2e4. Wi-Fi\ub294 \ubcf4\ud1b5 \ud574\ub2f9\ub418\uc9c0 \uc54a\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Restricts user and non-essential system apps, including Play services, Play Store and Galaxy Store. Notifications, alarms, calls, connectivity and background work can fail. Removes their user-added Doze exemptions. Protects core UIDs, Settings, SystemUI, credential and permission components, launcher, enabled keyboards, accessibility services and device administrators. Reapply after installing apps. Foreground services and OS exemptions can still run."

    const-string v1, "Play \uc11c\ube44\uc2a4, Play \uc2a4\ud1a0\uc5b4, \uac24\ub7ed\uc2dc \uc2a4\ud1a0\uc5b4\ub97c \ud3ec\ud568\ud574 \uc0ac\uc6a9\uc790 \uc571\uacfc \ud544\uc218\uac00 \uc544\ub2cc \uc2dc\uc2a4\ud15c \uc571\uc744 \uc81c\ud55c\ud569\ub2c8\ub2e4. \uc54c\ub9bc, \uc54c\ub78c, \uc804\ud654, \uc5f0\uacb0, \ubc31\uadf8\ub77c\uc6b4\ub4dc \uc791\uc5c5\uc774 \uc2e4\ud328\ud560 \uc218 \uc788\uc2b5\ub2c8\ub2e4. \uc0ac\uc6a9\uc790\uac00 \ucd94\uac00\ud55c Doze \uc608\uc678\ub3c4 \uc81c\uac70\ud569\ub2c8\ub2e4. \ud575\uc2ec UID, \uc124\uc815, SystemUI, \uc778\uc99d\u00b7\uad8c\ud55c \uad6c\uc131\uc694\uc18c, \ub7f0\ucc98, \uc0ac\uc6a9 \uc911\uc778 \ud0a4\ubcf4\ub4dc, \uc811\uadfc\uc131 \uc11c\ube44\uc2a4, \uae30\uae30 \uad00\ub9ac\uc790\ub294 \ubcf4\ud638\ub429\ub2c8\ub2e4. \uc571\uc744 \uc124\uce58\ud55c \ub4a4\uc5d0\ub294 \ub2e4\uc2dc \uc801\uc6a9\ud558\uc138\uc694. \ud3ec\uadf8\ub77c\uc6b4\ub4dc \uc11c\ube44\uc2a4\uc640 OS \uc608\uc678\ub294 \uacc4\uc18d \uc2e4\ud589\ub420 \uc218 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Resume backup refresh"

    const-string v1, "\ubc31\uc5c5 \uac31\uc2e0 \uc774\uc5b4\uc11c \ud558\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Resume backup refresh?"

    const-string v1, "\ubc31\uc5c5 \uac31\uc2e0\uc744 \uc774\uc5b4\uc11c \ud560\uae4c\uc694?"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Review LSPosed scope."

    const-string v1, "LSPosed \ubc94\uc704\ub97c \ud655\uc778\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Review and send"

    const-string v1, "\ud655\uc778 \ud6c4 \ubcf4\ub0b4\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Review before sending online"

    const-string v1, "\uc628\ub77c\uc778\uc73c\ub85c \ubcf4\ub0b4\uae30 \uc804\uc5d0 \ud655\uc778"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Review crash details"

    const-string v1, "\ud06c\ub798\uc2dc \uc815\ubcf4 \ud655\uc778"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private static fill5(Ljava/util/HashMap;)V
    .locals 2

    const-string v0, "Review crash details and backend"

    const-string v1, "\ud06c\ub798\uc2dc \uc815\ubcf4\uc640 \ubc31\uc5d4\ub4dc \ud655\uc778"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Review each request before sending. No device changes are made by the chat."

    const-string v1, "\ubcf4\ub0b4\uae30 \uc804\uc5d0 \uc694\uccad\ub9c8\ub2e4 \ud655\uc778\ud558\uc138\uc694. \ub300\ud654\ub85c \uae30\uae30 \uc124\uc815\uc774 \ubc14\ub00c\uc9c0\ub294 \uc54a\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Review in LSPosed Manager"

    const-string v1, "LSPosed \uad00\ub9ac\uc790\uc5d0\uc11c \ud655\uc778"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Review local AI request"

    const-string v1, "\uae30\uae30 AI \uc694\uccad \ud655\uc778"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Review or edit the selected log section"

    const-string v1, "\uc120\ud0dd\ud55c \ub85c\uadf8 \uad6c\uac04 \ud655\uc778 \ub610\ub294 \ud3b8\uc9d1"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Review previous module actions"

    const-string v1, "\uc774\uc804 \ubaa8\ub4c8 \uc791\uc5c5 \ud655\uc778"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Review recommended"

    const-string v1, "\ud655\uc778 \uad8c\uc7a5"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Review setup report"

    const-string v1, "\uc124\uc815 \ubcf4\uace0\uc11c \ud655\uc778"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Review the report before using your active backend"

    const-string v1, "\ud65c\uc131 \ubc31\uc5d4\ub4dc\ub97c \uc4f0\uae30 \uc804\uc5d0 \ubcf4\uace0\uc11c\ub97c \ud655\uc778\ud558\uc138\uc694"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Rollback ZIP saved and verified. Keep it accessible from recovery."

    const-string v1, "\ub864\ubc31 ZIP\uc744 \uc800\uc7a5\ud558\uace0 \uac80\uc99d\ud588\uc2b5\ub2c8\ub2e4. \ub9ac\ucee4\ubc84\ub9ac\uc5d0\uc11c \uc811\uadfc\ud560 \uc218 \uc788\ub294 \uacf3\uc5d0 \ubcf4\uad00\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Rollback journal capacity exceeded; no new controls applied"

    const-string v1, "\ub864\ubc31 \uae30\ub85d \uc6a9\ub7c9\uc744 \ub118\uc5b4 \uc0c8 \ud56d\ubaa9\uc740 \uc801\uc6a9\ud558\uc9c0 \uc54a\uc558\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Root modules"

    const-string v1, "\ub8e8\ud2b8 \ubaa8\ub4c8"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Run a read-only check of PIF and TEE settings."

    const-string v1, "PIF\uc640 TEE \uc124\uc815\uc744 \uc77d\uae30 \uc804\uc6a9\uc73c\ub85c \uc810\uac80\ud569\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Run a scan to check LSPosed conflicts."

    const-string v1, "\uac80\uc0ac\ub97c \uc2e4\ud589\ud574 LSPosed \ucda9\ub3cc\uc744 \ud655\uc778\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Run a scan to check for duplicate features."

    const-string v1, "\uac80\uc0ac\ub97c \uc2e4\ud589\ud574 \uc911\ubcf5 \uae30\ub2a5\uc744 \ud655\uc778\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Runtime freezer state not reported; no change made by Balanced"

    const-string v1, "\uc2e4\ud589 \uc911 \ub3d9\uacb0 \uc0c1\ud0dc\uac00 \ubcf4\uace0\ub418\uc9c0 \uc54a\uc544 \uade0\ud615 \ubaa8\ub4dc\uc5d0\uc11c \ubcc0\uacbd\ud558\uc9c0 \uc54a\uc558\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Runtime verified \u2014 fresh backend reports connected interceptor, acknowledged configuration and loaded keybox. App-specific interception and Google acceptance remain unverified."

    const-string v1, "\uc2e4\ud589 \ud655\uc778\ub428 \u2014 \ubc31\uc5d4\ub4dc\uac00 \uc778\ud130\uc149\ud130 \uc5f0\uacb0, \uc124\uc815 \ubc18\uc601, \ud0a4\ubc15\uc2a4 \ub85c\ub4dc\ub97c \ubcf4\uace0\ud588\uc2b5\ub2c8\ub2e4. \uc571\ubcc4 \uac00\ub85c\ucc44\uae30\uc640 Google\uc758 \uc218\ub77d \uc5ec\ubd80\ub294 \ud655\uc778\ub418\uc9c0 \uc54a\uc558\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Same purpose as UN1CA\u2019s "

    const-string v1, "UN1CA\uc640 \uac19\uc740 \uae30\ub2a5: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Save original log"

    const-string v1, "\uc6d0\ubcf8 \ub85c\uadf8 \uc800\uc7a5"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Save rollback ZIP"

    const-string v1, "\ub864\ubc31 ZIP \uc800\uc7a5"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Save the original before making changes"

    const-string v1, "\ubcc0\uacbd\ud558\uae30 \uc804\uc5d0 \uc6d0\ubcf8 \uc800\uc7a5"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Save your work before restarting."

    const-string v1, "\uc7ac\uc2dc\uc791\ud558\uae30 \uc804\uc5d0 \uc791\uc5c5\uc744 \uc800\uc7a5\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Saved app state available for restoration"

    const-string v1, "\ubcf5\uc6d0\ud560 \uc218 \uc788\ub294 \uc800\uc7a5\ub41c \uc571 \uc0c1\ud0dc\uac00 \uc788\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Saved copy verified"

    const-string v1, "\uc800\uc7a5\ub41c \uc0ac\ubcf8 \uac80\uc99d \uc644\ub8cc"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Saved profile verification failed"

    const-string v1, "\uc800\uc7a5\ub41c \ud504\ub85c\ud544 \uac80\uc99d \uc2e4\ud328"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Saved rollback ZIP verification failed"

    const-string v1, "\uc800\uc7a5\ub41c \ub864\ubc31 ZIP \uac80\uc99d \uc2e4\ud328"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Saving and verifying recovery rollback ZIP\u2026"

    const-string v1, "\ub9ac\ucee4\ubc84\ub9ac \ub864\ubc31 ZIP \uc800\uc7a5 \ubc0f \uac80\uc99d \uc911\u2026"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Saving original log\u2026"

    const-string v1, "\uc6d0\ubcf8 \ub85c\uadf8 \uc800\uc7a5 \uc911\u2026"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Saving tuning profile\u2026"

    const-string v1, "\ud29c\ub2dd \ud504\ub85c\ud544 \uc800\uc7a5 \uc911\u2026"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Scan completed. Review evidence below."

    const-string v1, "\uac80\uc0ac\uac00 \ub05d\ub0ac\uc2b5\ub2c8\ub2e4. \uc544\ub798 \uadfc\uac70\ub97c \ud655\uc778\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Scan incomplete"

    const-string v1, "\uac80\uc0ac \ubbf8\uc644\ub8cc"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Scan installed modules"

    const-string v1, "\uc124\uce58\ub41c \ubaa8\ub4c8 \uac80\uc0ac"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Scan installed modules to check for overlaps."

    const-string v1, "\uc124\uce58\ub41c \ubaa8\ub4c8\uc744 \uac80\uc0ac\ud574 \uacb9\uce58\ub294 \uae30\ub2a5\uc744 \ud655\uc778\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Scan to view installed modules."

    const-string v1, "\uac80\uc0ac\ud558\uba74 \uc124\uce58\ub41c \ubaa8\ub4c8\uc774 \ud45c\uc2dc\ub429\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Scanning installed modules\u2026"

    const-string v1, "\uc124\uce58\ub41c \ubaa8\ub4c8 \uac80\uc0ac \uc911\u2026"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Screen timeout"

    const-string v1, "\ud654\uba74 \uc790\ub3d9 \uaebc\uc9d0 \uc2dc\uac04"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Search camera features"

    const-string v1, "\uce74\uba54\ub77c \uae30\ub2a5 \uac80\uc0c9"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Select a UTF-8 text/log file; extract compressed or binary files first"

    const-string v1, "UTF-8 \ud14d\uc2a4\ud2b8/\ub85c\uadf8 \ud30c\uc77c\uc744 \uc120\ud0dd\ud558\uc138\uc694. \uc555\ucd95 \ud30c\uc77c\uc774\ub098 \ubc14\uc774\ub108\ub9ac\ub294 \uba3c\uc800 \ud480\uc5b4\uc57c \ud569\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Select a plain text log; extract compressed or binary files first"

    const-string v1, "\uc77c\ubc18 \ud14d\uc2a4\ud2b8 \ub85c\uadf8\ub97c \uc120\ud0dd\ud558\uc138\uc694. \uc555\ucd95 \ud30c\uc77c\uc774\ub098 \ubc14\uc774\ub108\ub9ac\ub294 \uba3c\uc800 \ud480\uc5b4\uc57c \ud569\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Select a single CA certificate"

    const-string v1, "CA \uc778\uc99d\uc11c \ud558\ub098\ub97c \uc120\ud0dd\ud558\uc138\uc694"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Select at least one non-empty log section"

    const-string v1, "\ube44\uc5b4 \uc788\uc9c0 \uc54a\uc740 \ub85c\uadf8 \uad6c\uac04\uc744 \ud558\ub098 \uc774\uc0c1 \uc120\ud0dd\ud558\uc138\uc694"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Select at most 100 apps"

    const-string v1, "\uc571\uc740 \ucd5c\ub300 100\uac1c\uae4c\uc9c0 \uc120\ud0dd\ud560 \uc218 \uc788\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Selection not saved"

    const-string v1, "\uc120\ud0dd\uc774 \uc800\uc7a5\ub418\uc9c0 \uc54a\uc558\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Selection saved. Save and apply will confirm app disabling and restart."

    const-string v1, "\uc120\ud0dd\uc744 \uc800\uc7a5\ud588\uc2b5\ub2c8\ub2e4. \uc800\uc7a5 \ubc0f \uc801\uc6a9 \uc2dc \uc571 \ube44\ud65c\uc131\ud654\uc640 \uc7ac\uc2dc\uc791\uc744 \ud655\uc778\ud569\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Selection saved. Use Save and apply."

    const-string v1, "\uc120\ud0dd\uc744 \uc800\uc7a5\ud588\uc2b5\ub2c8\ub2e4. \uc800\uc7a5 \ubc0f \uc801\uc6a9\uc744 \ub204\ub974\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Send selected sections"

    const-string v1, "\uc120\ud0dd\ud55c \uad6c\uac04 \ubcf4\ub0b4\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Send this conversation online?"

    const-string v1, "\uc774 \ub300\ud654\ub97c \uc628\ub77c\uc778\uc73c\ub85c \ubcf4\ub0bc\uae4c\uc694?"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Separate voltage/OPP tables are not supported for this Samsung firmware"

    const-string v1, "\uc774 \uc0bc\uc131 \ud38c\uc6e8\uc5b4\ub294 \ubcc4\ub3c4 \uc804\uc555/OPP \ud45c\ub97c \uc9c0\uc6d0\ud558\uc9c0 \uc54a\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Set alarm"

    const-string v1, "\uc54c\ub78c \uc124\uc815"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Settings presets"

    const-string v1, "\uc124\uc815 \ud504\ub9ac\uc14b"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Show less"

    const-string v1, "\uc811\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Show more"

    const-string v1, "\ub354 \ubcf4\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Some changes failed; review details below"

    const-string v1, "\uc77c\ubd80 \ubcc0\uacbd\uc5d0 \uc2e4\ud328\ud588\uc2b5\ub2c8\ub2e4. \uc544\ub798 \ub0b4\uc6a9\uc744 \ud655\uc778\ud558\uc138\uc694"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Source rollback checksum mismatch"

    const-string v1, "\uc6d0\ubcf8 \ub864\ubc31 \uccb4\ud06c\uc12c\uc774 \uc77c\uce58\ud558\uc9c0 \uc54a\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Source: "

    const-string v1, "\ucd9c\ucc98: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Standby bucket"

    const-string v1, "\ub300\uae30 \ubc84\ud0b7"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Stingy selects 8 (captured from the device brightness setting) on Android\'s legacy 1\u2013255 setting scale; this is not a measured panel luminance percentage."

    const-string v1, "\ucd5c\ub300 \uc808\uc57d\uc740 Android\uc758 \uc608\uc804 1\u2013255 \ubc1d\uae30 \ub2e8\uacc4\uc5d0\uc11c 8(\uae30\uae30 \ubc1d\uae30 \uc124\uc815\uc5d0\uc11c \uce21\uc815)\uc744 \uc120\ud0dd\ud569\ub2c8\ub2e4. \uc2e4\uc81c \ud328\ub110 \ud718\ub3c4\uc758 \ubc31\ubd84\uc728\uc740 \uc544\ub2d9\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Subscription is not active; saved Wi-Fi Calling state retained"

    const-string v1, "\ud68c\uc120\uc774 \ud65c\uc131 \uc0c1\ud0dc\uac00 \uc544\ub2c8\ub77c \uc800\uc7a5\ub41c Wi-Fi \ud1b5\ud654 \uc0c1\ud0dc\ub97c \uc720\uc9c0\ud569\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Suggestion declined; finding remains for review."

    const-string v1, "\uc81c\uc548\uc744 \uac70\uc808\ud588\uc2b5\ub2c8\ub2e4. \ubc1c\uacac \ud56d\ubaa9\uc740 \uac80\ud1a0\uc6a9\uc73c\ub85c \ub0a8\uaca8\ub461\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "System crash"

    const-string v1, "\uc2dc\uc2a4\ud15c \ud06c\ub798\uc2dc"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "System dark mode"

    const-string v1, "\uc2dc\uc2a4\ud15c \ub2e4\ud06c \ubaa8\ub4dc"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Table "

    const-string v1, "\ud45c "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Table count or initial/minimum index is invalid"

    const-string v1, "\ud45c \uac1c\uc218\ub098 \ucd08\uae30/\ucd5c\uc18c \uc778\ub371\uc2a4\uac00 \uc798\ubabb\ub418\uc5c8\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Tables exceed the original FDT space. Remove a level before adding another."

    const-string v1, "\ud45c\uac00 \uc6d0\ub798 FDT \uacf5\uac04\uc744 \ub118\uc2b5\ub2c8\ub2e4. \ub2e8\uacc4\ub97c \ucd94\uac00\ud558\uae30 \uc804\uc5d0 \ud558\ub098\ub97c \uc9c0\uc6b0\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Tap Scan installed modules to begin."

    const-string v1, "\uc2dc\uc791\ud558\ub824\uba74 \uc124\uce58\ub41c \ubaa8\ub4c8 \uac80\uc0ac\ub97c \ub204\ub974\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Tap to configure"

    const-string v1, "\ub20c\ub7ec\uc11c \uc124\uc815"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Tap to cycle Off \u2192 Auto \u2192 saved provider. The provider must support Private DNS."

    const-string v1, "\ub204\ub97c \ub54c\ub9c8\ub2e4 \ub054 \u2192 \uc790\ub3d9 \u2192 \uc800\uc7a5\ub41c \uc81c\uacf5\uc790\ub85c \ubc14\ub01d\ub2c8\ub2e4. \uc81c\uacf5\uc790\uac00 \uac1c\uc778 DNS\ub97c \uc9c0\uc6d0\ud574\uc57c \ud569\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Tap to expand or collapse crash details"

    const-string v1, "\ub20c\ub7ec\uc11c \ud06c\ub798\uc2dc \uc815\ubcf4 \ud3bc\uce58\uae30/\uc811\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Tap to expand or collapse setup details"

    const-string v1, "\ub20c\ub7ec\uc11c \uc124\uc815 \uc815\ubcf4 \ud3bc\uce58\uae30/\uc811\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "The AI backend changed. Refresh it and review the request again before sending."

    const-string v1, "AI \ubc31\uc5d4\ub4dc\uac00 \ubc14\ub00c\uc5c8\uc2b5\ub2c8\ub2e4. \uc0c8\ub85c\uace0\uce68\ud55c \ub4a4 \uc694\uccad\uc744 \ub2e4\uc2dc \ud655\uc778\ud558\uace0 \ubcf4\ub0b4\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "The system did not accept the change"

    const-string v1, "\uc2dc\uc2a4\ud15c\uc774 \ubcc0\uacbd\uc744 \ubc1b\uc544\ub4e4\uc774\uc9c0 \uc54a\uc558\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "This KonaBess export is not for kalama"

    const-string v1, "\uc774 KonaBess \ub0b4\ubcf4\ub0b4\uae30\ub294 kalama\uc6a9\uc774 \uc544\ub2d9\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "This action is not available"

    const-string v1, "\uc774 \uc791\uc5c5\uc744 \uc0ac\uc6a9\ud560 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "This app has no available shortcuts. You can assign Open app instead."

    const-string v1, "\uc774 \uc571\uc5d0\ub294 \uc0ac\uc6a9\ud560 \uc218 \uc788\ub294 \ubc14\ub85c\uac00\uae30\uac00 \uc5c6\uc2b5\ub2c8\ub2e4. \ub300\uc2e0 \uc571 \uc5f4\uae30\ub97c \uc9c0\uc815\ud560 \uc218 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "This app is no longer available"

    const-string v1, "\uc774 \uc571\uc744 \ub354 \uc774\uc0c1 \uc0ac\uc6a9\ud560 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "This device \u2014 PIF and TEE setup report"

    const-string v1, "\uc774 \uae30\uae30 \u2014 PIF \ubc0f TEE \uc124\uc815 \ubcf4\uace0\uc11c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "This device \u2014 recent logcat and dedicated crash buffer"

    const-string v1, "\uc774 \uae30\uae30 \u2014 \ucd5c\uadfc logcat \ubc0f \ud06c\ub798\uc2dc \uc804\uc6a9 \ubc84\ud37c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "This is not a CA certificate"

    const-string v1, "CA \uc778\uc99d\uc11c\uac00 \uc544\ub2d9\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "This module changes files related to a built-in UN1CA feature."

    const-string v1, "\uc774 \ubaa8\ub4c8\uc740 UN1CA \ub0b4\uc7a5 \uae30\ub2a5\uacfc \uad00\ub828\ub41c \ud30c\uc77c\uc744 \ubc14\uafc9\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "This module conflicts with a built-in UN1CA feature."

    const-string v1, "\uc774 \ubaa8\ub4c8\uc740 UN1CA \ub0b4\uc7a5 \uae30\ub2a5\uacfc \ucda9\ub3cc\ud569\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "This module serves the same purpose as a built-in UN1CA feature."

    const-string v1, "\uc774 \ubaa8\ub4c8\uc740 UN1CA \ub0b4\uc7a5 \uae30\ub2a5\uacfc \uac19\uc740 \uc5ed\ud560\uc744 \ud569\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "This request exceeds the local model\'s token budget. Shorten the log or question, clear older chat history, or select an online backend in AI Settings."

    const-string v1, "\uc774 \uc694\uccad\uc740 \uae30\uae30 \ubaa8\ub378\uc758 \ud1a0\ud070 \ud55c\ub3c4\ub97c \ub118\uc2b5\ub2c8\ub2e4. \ub85c\uadf8\ub098 \uc9c8\ubb38\uc744 \uc904\uc774\uac70\ub098, \uc774\uc804 \ub300\ud654\ub97c \uc9c0\uc6b0\uac70\ub098, AI \uc124\uc815\uc5d0\uc11c \uc628\ub77c\uc778 \ubc31\uc5d4\ub4dc\ub97c \uc120\ud0dd\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Too many controls"

    const-string v1, "\ud56d\ubaa9\uc774 \ub108\ubb34 \ub9ce\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Too many device-tree tokens"

    const-string v1, "\ub514\ubc14\uc774\uc2a4 \ud2b8\ub9ac \ud1a0\ud070\uc774 \ub108\ubb34 \ub9ce\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Troubleshooting"

    const-string v1, "\ubb38\uc81c \ud574\uacb0"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Troubleshooting is available to the device owner only."

    const-string v1, "\ubb38\uc81c \ud574\uacb0\uc740 \uae30\uae30 \uc18c\uc720\uc790\ub9cc \uc0ac\uc6a9\ud560 \uc218 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Troubleshooting service is not installed. Install the updated ROM."

    const-string v1, "\ubb38\uc81c \ud574\uacb0 \uc11c\ube44\uc2a4\uac00 \uc124\uce58\ub418\uc5b4 \uc788\uc9c0 \uc54a\uc2b5\ub2c8\ub2e4. \ucd5c\uc2e0 \ub86c\uc744 \uc124\uce58\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Truncated GPU property"

    const-string v1, "GPU \uc18d\uc131\uc774 \uc798\ub824 \uc788\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Truncated KonaBess table"

    const-string v1, "KonaBess \ud45c\uac00 \uc798\ub824 \uc788\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Truncated profile JSON"

    const-string v1, "\ud504\ub85c\ud544 JSON\uc774 \uc798\ub824 \uc788\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Tuning profile saved and verified. Share this JSON file; keep your recovery rollback ZIP separately."

    const-string v1, "\ud29c\ub2dd \ud504\ub85c\ud544\uc744 \uc800\uc7a5\ud558\uace0 \uac80\uc99d\ud588\uc2b5\ub2c8\ub2e4. \uc774 JSON \ud30c\uc77c\uc740 \uacf5\uc720\ud574\ub3c4 \ub418\uba70, \ub9ac\ucee4\ubc84\ub9ac\uc6a9 \ub864\ubc31 ZIP\uc740 \ub530\ub85c \ubcf4\uad00\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Unable to complete: "

    const-string v1, "\uc644\ub8cc\ud560 \uc218 \uc5c6\uc74c: "

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Unbalanced profile JSON"

    const-string v1, "\ud504\ub85c\ud544 JSON\uc758 \uad04\ud638\uac00 \ub9de\uc9c0 \uc54a\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Undo changes made by Troubleshooting"

    const-string v1, "\ubb38\uc81c \ud574\uacb0\uc5d0\uc11c \ubc14\uafbc \ub0b4\uc6a9 \ub418\ub3cc\ub9ac\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Unexpected SDHMS data directory"

    const-string v1, "\uc608\uc0c1\ud558\uc9c0 \ubabb\ud55c SDHMS \ub370\uc774\ud130 \ud3f4\ub354"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Unexpected SystemUI UID; restart cancelled"

    const-string v1, "SystemUI UID\uac00 \uc608\uc0c1\uacfc \ub2ec\ub77c \uc7ac\uc2dc\uc791\uc744 \ucde8\uc18c\ud588\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Unexpected extra KonaBess data"

    const-string v1, "\uc608\uc0c1\ud558\uc9c0 \ubabb\ud55c \ucd94\uac00 KonaBess \ub370\uc774\ud130"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Unexpected nested GPU node"

    const-string v1, "\uc608\uc0c1\ud558\uc9c0 \ubabb\ud55c \uc911\ucca9 GPU \ub178\ub4dc"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Unknown KonaBess export field"

    const-string v1, "\uc54c \uc218 \uc5c6\ub294 KonaBess \ub0b4\ubcf4\ub0b4\uae30 \ud56d\ubaa9"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Unknown predefined action"

    const-string v1, "\uc54c \uc218 \uc5c6\ub294 \uae30\ubcf8 \uc791\uc5c5"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Unknown preset"

    const-string v1, "\uc54c \uc218 \uc5c6\ub294 \ud504\ub9ac\uc14b"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Unknown profile field"

    const-string v1, "\uc54c \uc218 \uc5c6\ub294 \ud504\ub85c\ud544 \ud56d\ubaa9"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Unsupported battery profile format/version"

    const-string v1, "\uc9c0\uc6d0\ud558\uc9c0 \uc54a\ub294 \ubc30\ud130\ub9ac \ud504\ub85c\ud544 \ud615\uc2dd/\ubc84\uc804"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Unsupported content in KonaBess device-tree data"

    const-string v1, "KonaBess \ub514\ubc14\uc774\uc2a4 \ud2b8\ub9ac \ub370\uc774\ud130\uc5d0 \uc9c0\uc6d0\ud558\uc9c0 \uc54a\ub294 \ub0b4\uc6a9\uc774 \uc788\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Unsupported on this device"

    const-string v1, "\uc774 \uae30\uae30\uc5d0\uc11c \uc9c0\uc6d0\ud558\uc9c0 \uc54a\uc74c"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Updating module\u2026"

    const-string v1, "\ubaa8\ub4c8 \uc5c5\ub370\uc774\ud2b8 \uc911\u2026"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Validate configuration and check backend readiness"

    const-string v1, "\uc124\uc815 \uac80\uc99d \ubc0f \ubc31\uc5d4\ub4dc \uc900\ube44 \uc0c1\ud0dc \ud655\uc778"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Value is outside this device\'s available choices"

    const-string v1, "\uc774 \uae30\uae30\uc5d0\uc11c \uace0\ub97c \uc218 \uc788\ub294 \uac12\uc774 \uc544\ub2d9\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Verify old rollback in /data, free its cache space and back up this ROM; profile stays saved"

    const-string v1, "/data\uc758 \uc774\uc804 \ub864\ubc31\uc744 \uac80\uc99d\ud558\uace0 \uce90\uc2dc \uacf5\uac04\uc744 \ube44\uc6b4 \ub4a4 \uc774 \ub86c\uc744 \ubc31\uc5c5\ud569\ub2c8\ub2e4. \ud504\ub85c\ud544\uc740 \uadf8\ub300\ub85c \uc800\uc7a5\ub429\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "View setup results"

    const-string v1, "\uc124\uc815 \uacb0\uacfc \ubcf4\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Voltage request"

    const-string v1, "\uc804\uc555 \uc694\uccad"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "What the scan can detect"

    const-string v1, "\uac80\uc0ac\ub85c \ucc3e\uc744 \uc218 \uc788\ub294 \uac83"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Wi-Fi radio"

    const-string v1, "Wi-Fi \ubb34\uc120"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Wi-Fi request rejected"

    const-string v1, "Wi-Fi \uc694\uccad\uc774 \uac70\ubd80\ub418\uc5c8\uc2b5\ub2c8\ub2e4"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Wi-Fi runtime power"

    const-string v1, "Wi-Fi \ub7f0\ud0c0\uc784 \uc804\uc6d0"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Wi-Fi scanning while off"

    const-string v1, "\uaebc\uc838 \uc788\uc744 \ub54c Wi-Fi \uac80\uc0c9"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Wi-Fi settings"

    const-string v1, "Wi-Fi \uc124\uc815"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Wi-Fi state is changing or unavailable; retry when stable"

    const-string v1, "Wi-Fi \uc0c1\ud0dc\uac00 \ubc14\ub00c\ub294 \uc911\uc774\uac70\ub098 \uc0ac\uc6a9\ud560 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4. \uc548\uc815\ub418\uba74 \ub2e4\uc2dc \uc2dc\ub3c4\ud558\uc138\uc694"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Wi-Fi wakeup"

    const-string v1, "Wi-Fi \uc790\ub3d9 \ucf1c\uae30"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Wireless debugging"

    const-string v1, "\ubb34\uc120 \ub514\ubc84\uae45"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Working\u2026"

    const-string v1, "\ucc98\ub9ac \uc911\u2026"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "You kept a flagged module enabled. Review the recommendation below."

    const-string v1, "\ubb38\uc81c\ub85c \ud45c\uc2dc\ub41c \ubaa8\ub4c8\uc744 \uacc4\uc18d \uc0ac\uc6a9 \uc911\uc785\ub2c8\ub2e4. \uc544\ub798 \uad8c\uc7a5 \uc0ac\ud56d\uc744 \ud655\uc778\ud558\uc138\uc694."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Your message"

    const-string v1, "\ub0b4 \uba54\uc2dc\uc9c0"

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Zero removes optional animation work; apps may ignore this scale."

    const-string v1, "0\uc73c\ub85c \ud558\uba74 \uc120\ud0dd\uc801\uc778 \uc560\ub2c8\uba54\uc774\uc158 \uc791\uc5c5\uc744 \uc5c6\uc571\ub2c8\ub2e4. \uc571\uc774 \uc774 \ubc30\uc728\uc744 \ubb34\uc2dc\ud560 \uc218 \uc788\uc2b5\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "Checks known duplicate-purpose root modules, selected modified files, known LSPosed duplicate purposes, and verified LSPosed conflicts. Duplicate purpose does not prove a crash or a failed integrity check. Built-in files must be present, but this does not prove that feature is enabled or working. Dynamic hooks and scripts may be missed. LSPosed checks require an exact package and matching enabled scope. Duplicate-purpose rules also require the built-in framework class. They do not establish runtime hook execution. Confirmed conflicts require additional verified evidence."

    const-string v1, "\uc54c\ub824\uc9c4 \uc911\ubcf5 \uae30\ub2a5 \ub8e8\ud2b8 \ubaa8\ub4c8, \uc120\ud0dd\ub41c \uc218\uc815 \ud30c\uc77c, \uc54c\ub824\uc9c4 LSPosed \uc911\ubcf5 \uae30\ub2a5, \ud655\uc778\ub41c LSPosed \ucda9\ub3cc\uc744 \uc810\uac80\ud569\ub2c8\ub2e4. \uae30\ub2a5\uc774 \uacb9\uce5c\ub2e4\uace0 \ud06c\ub798\uc2dc\ub098 \ubb34\uacb0\uc131 \uac80\uc0ac \uc2e4\ud328\uac00 \uc99d\uba85\ub418\uc9c0\ub294 \uc54a\uc2b5\ub2c8\ub2e4. \ub0b4\uc7a5 \ud30c\uc77c\uc774 \uc788\uc5b4\uc57c \ud558\uc9c0\ub9cc, \uadf8 \uae30\ub2a5\uc774 \ucf1c\uc838 \uc788\uac70\ub098 \ub3d9\uc791\ud55c\ub2e4\ub294 \ub73b\uc740 \uc544\ub2d9\ub2c8\ub2e4. \ub3d9\uc801 \ud6c4\ud0b9\uacfc \uc2a4\ud06c\ub9bd\ud2b8\ub294 \ub193\uce60 \uc218 \uc788\uc2b5\ub2c8\ub2e4. LSPosed \uc810\uac80\uc740 \uc815\ud655\ud55c \ud328\ud0a4\uc9c0\uc640 \uc77c\uce58\ud558\ub294 \ud65c\uc131 \ubc94\uc704\uac00 \ud544\uc694\ud569\ub2c8\ub2e4. \uc911\ubcf5 \uae30\ub2a5 \uaddc\uce59\uc740 \ub0b4\uc7a5 \ud504\ub808\uc784\uc6cc\ud06c \ud074\ub798\uc2a4\ub3c4 \ud544\uc694\ud558\uba70, \uc2e4\ud589 \uc911 \ud6c4\ud0b9 \uc5ec\ubd80\ub294 \ud655\uc778\ud558\uc9c0 \uc54a\uc2b5\ub2c8\ub2e4. \ucda9\ub3cc \ud655\uc815\uc5d0\ub294 \ucd94\uac00 \uadfc\uac70\uac00 \ud544\uc694\ud569\ub2c8\ub2e4."

    invoke-virtual {p0, v0, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method
