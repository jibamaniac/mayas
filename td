def create_window():
    window_name = "myWindow_v012"
    if cmds.window(window_name, exists=True):
        cmds.deleteUI(window_name)

    cmds.window(window_name, title="Geo Checks: Mix & Match", widthHeight=(400, 1000), backgroundColor=(0.2, 0.2, 0.2))
    cmds.columnLayout(adjustableColumn=True, rowSpacing=10)

    cmds.text(label="Mix & Match Penetrations", align="center", font="boldLabelFont", backgroundColor=(0.7, 0.7, 0.7))
    cmds.optionMenu("dropdown_menu_long", backgroundColor=(.15, .25, .5), label="Select A Guide", changeCommand=select_objects_full)

    global checkRed
    checkboxes = {
        "checkRed": cmds.checkBox(label="Bake/UnBake Intersections", changeCommand=display_red),
        "shaded": cmds.checkBox(label="Display Guides Shaded", changeCommand=toggleDisplayShaded),
        "iso": cmds.checkBox(label="Iso Caps and Body", changeCommand=iso_caps_body)
    }

    cmds.text(label="Quality Checks", align="center", font="boldLabelFont", backgroundColor=(0.7, 0.7, 0.7))
    buttons = [('Toggle WireFrame', ToggleWireframeonShaded), ('Toggle HUD', toggleHud), ('Toggle Xray', toggleXray)]
    [cmds.button(label=lbl, backgroundColor=(.15, .25, .5), width=125, command=cmd) for lbl, cmd in buttons]

    for label, command in [('Perimeter', getEdges), ('Triangles', getTris), ('NGons', getnGons)]:
        cmds.button(label=label, backgroundColor=(.15, .25, .5), width=125, command=command)

    for label, command in [('Hard Edges', disHardEdgs), ('Standard Edges', disStandEdgs), ('Check Non Manifold', getNonMan)]:
        cmds.button(label=label, backgroundColor=(.15, .25, .5), width=125, command=command)

    cmds.text(label="Check LOD Vertex Count", align="center", font="boldLabelFont", backgroundColor=(0.7, 0.7, 0.7))
    for label, command in [('LOD0 Vertex Count', lod0), ('LOD1 Vertex Count', lod1), ('LOD2 Vertex Count', lod2)]:
        cmds.button(label=label, backgroundColor=(.15, .25, .5), width=125, command=command)

    cmds.text(label="Hard/Soft Normals & Check Naming", align="center", font="boldLabelFont", backgroundColor=(0.7, 0.7, 0.7))
    for label, command in [('Hard Text Border', hardBorder), ('All Soft', lod1), ('Check Asset Naming', finalCheckNamingConvention)]:
        cmds.button(label=label, backgroundColor=(.15, .25, .5), width=125, command=command)

    global checkGreen, checkBlue, checkYellow, rayCheckBox
    checkGreen = cmds.checkBox(label="Texel Density", changeCommand=texelDensity)
    checkBlue = cmds.checkBox(label="UV Checkers", changeCommand=checkers)
    checkYellow = cmds.checkBox(label="Texen Density_V2", changeCommand=texelDensityCustom)

    rayCheckBox = cmds.checkBox(label="Convert Guides to Ray", changeCommand=select_asset_type)
    cmds.button(label="Select and Set/Reset Vertices", command=on_selected_vertices_button, backgroundColor=(.15, .24, .5))

    cmds.rowLayout(numberOfColumns=3, columnAlign=(1, 'center'), columnAttach=(1, 'both', 5))
    global x_field, y_field, z_field
    x_field, y_field, z_field = [cmds.floatField(minValue=-1, maxValue=1, precision=5, step=0.01, width=125) for _ in range(3)]

    cmds.button(label="Ray To Target", command=on_general_button_v2, backgroundColor=(0.3, 0.5, 0.7))
    cmds.button(label="Clean Up", command=on_cleanUp, backgroundColor=(0.5, 0.7, 0.9))

    cmds.showWindow(window)

create_window()
