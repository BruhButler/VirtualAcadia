Version 1.4.0
-------------
* Added a 'Open Dynamic Preview' entry to asset context menu that opens a panel where you can rotate around an asset in 3D, with an option to update the asset thumbnail from this perspective
* Switched asset preview generation to use polar coordinates. This facilitated a new project setting to modify the angle at which assets are previewed at the horizontal default perspectives.
* Added a 'Generate Asset Zoo' entry to the library context menu, that creates an asset zoo scene with the assets in the library
* Added a Setting to set background color for dynamic preview panel
* Fixed option buttons not having selections in 4.0.x
* Added .mesh file endings to supported file formats
* Updated Terrain3D placement controller to account for API changes in 0.9.3
* Fixed an error thrown upon opening right click context menus

Version 1.3.1
-------------
* Updated EULA
* Fixed popup submenus not appearing in 4.3

Version 1.3.0
-------------
* Integrated a Terrain3D placement mode, that requires no physics collisions
* Switched saved placement mode property to string
* Changed placement controllers internally to be nodes instead of objects

Version 1.2.3
-------------
* Fixed a Nullpointer due to unexpected cleanup of Tooltip panel
* Fixed a case issue with the Grid resource path
* Replaced default icon with custom AssetPlacer icon 

Version 1.2.2
-------------
* Fixed performance issue by plugin reload generating previews for all opened libraries at once
* Fixed tab adding emitting signal on library load, leading to dict key exception on plugin reload
* Order of opened library tabs is now preserved when plugin is reloaded
* Fixed an error on reloading plugin when an unnamed library was open

Version 1.2.1
--------------
* Fixed (mostly UI-related) issues with Godot 4.2
* Fixed an issue when reloading thumbnails of broken assets

Version 1.2
-------------
* Added a text filter
* Added a button to match selected node to asset
* Fixed a performance issue when switching libraries and adding assets
* Allow use of .scn files
* Always add file endings to asset names
* Made ContextlessPlugin compatible with scaled viewports
* Improved handling invalid file paths, i.e. deleted or moved files
* Changed detach window button to use "Make Floating" icon if Godot version is 4.1 or later
* Added tooltip to Reset Transformation button
* Fixed popups not being positioned correctly when using multiple displays
* Fixed library preview perspective not being persisted
* Fixed an issue with using directives
* Fixed popups not being positioned correctly when using multiple displays

Version 1.1.0
-------------
* Added a button to detach the AssetPlacer UI panel
* Implemented placement of Mesh resources, and OBJs imported as Meshes
* Added a button to reset transformed assets
* Fixed compatibility with several other plugins that add custom UI
* Implemented synchronisation of version numbers
* Fixed scene not being marked as dirty when placing assets with the plugin, by using local change history instead of global
* Allow placing assets under a non-Node3D descendent
* Improved error handling when plugin was not installed correctly 
* Made use of compiler directives to support different Godot versions in one build
* Added social media links to About page
* Fixed popups not popping up in the screen center
* Fixed a transient window error message (if using Godot 4.1 or above)
* Set initial values properly for custom project settings
* Implemented warning if Terrain3D is detected with no debug collisions enabled
* Fixed an error message when clicking at an empty location in surface placement node

Version 1.0.3
-------------
* Fixed a compatibility problem with Terrain3D - detect if terrain_3d is active and adjust NodePaths accordingly.

Version 1.0.2
-------------
* Fixed an issue when closing or switching libraries while an asset is selected
* Fixed an issue when the .assetPlacer/data.tres file is corrupt due to a faulty install

Version 1.0.1
--------------
* Fixed an issue with library file dialogs not opening in the right folder
* Changed uses of Godot Collections to be explicit
* Fixed various compiler warnings