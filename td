import maya.cmds as cmds
import maya.mel as mel

asset0 = cmds.ls(selection=True)
asset=asset0[0]
cmds.select(asset, replace=True)
mel.eval('expandPolyGroupSelection; polyColorPerVertex -r 1 -g 1 -b 1 -a 1 -cdo;')

vDict = {}
cmds.ConvertSelectionToVertices()
allVts = cmds.ls(selection=True, flatten=True)

for vtx in allVts:
    cmds.select(vtx, replace=True)
    mel.eval('uvTkDoGetTexelDensity;')
    mel.eval('uvTkDoGetTexelDensity;')  # Executed twice as per original logic
    td = cmds.optionVar(query='polyUVTexelDensity')
    vDict[str(vtx)] = td

# Get min and max texel densities
values2 = list(vDict.values())
minVal = min(values)
maxVal = max(values)
print(values2)
# Normalize the values
normDict = {}
for k, v in vDict.items():
    if maxVal > minVal:
        normVal = ((v - minVal) / (maxVal - minVal) * 2) - 1  # Normalize to range [-1, 1]
    else:
        normVal = 0  # If all values are the same, set the normalized value to 0
    normDict[k] = normVal
print(vDict)
# Set the display color channel to 'none'
print(asset)
cmds.setAttr('{}.displayColorChannel'.format(asset), "none", type='string')

# Assign colors based on normalized texel density values
for k, v in normDict.items():
    color = (0.25, v, 0.25)  # Greenish color based on the normalized value
    cmds.polyColorPerVertex(k, rgb=color)
