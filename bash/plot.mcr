#!MC 1410
$!VarSet |MFBD| = '/storage/leading-edge-vortices/vortexrollup/archer/try2'
$!VarSet |FILEN| = '6'
$!PICK SETMOUSEMODE
  MOUSEMODE = SELECT
$!PAGE NAME = 'Untitled'
$!PAGECONTROL CREATE
$!PICK SETMOUSEMODE
  MOUSEMODE = SELECT
$!OPENLAYOUT  "/storage/leading-edge-vortices/vortexrollup/archer/try2/evolution.lay"
$!PRINTSETUP PALETTE = COLOR
$!EXPORTSETUP IMAGEWIDTH = 1067
$!EXPORTSETUP EXPORTFNAME = '/storage/leading-edge-vortices/vortexrollup/archer/try2/|FILEN|.png'
$!EXPORT
  EXPORTREGION = CURRENTFRAME
$!RemoveVar |FILEN|
$!RemoveVar |MFBD|
