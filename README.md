# Requirements:

## Create an application that queries the SpaceX Data API (https://api.spacexdata.com/v3/launches) to list all historical Launches and display extensive Launch details to the user.

**Summary details displayed in the list should include:** 

    Mission Name
    Rocket Name
    Launch Site Name
    Date of Launch
    Launch patch image, or default image when not provided by the API

**Each summary item should be clickable. When clicked the full mission details provided by the API should be displayed.**

**Rotation (orientation change) should be supported on all form factors.**

    - Portrait 
        - Launches shall be listed and ordered from newest to oldest.
        - when a Launch is selected the details screen shall be presented
    - Landscape
        - Large devices 
            - Shall display the Launch list and detail views in Master/Detail manner. 
            - When a Launch is selected the item shall remain highlighted in the list and the details view shall be populated with the selected Launch details.
        - Small devices![Simulator Screen Recording - iPad Pro 13-inch (M4) - 2024-09-20 at 19 03 59](https://github.com/user-attachments/assets/19168883-596d-47ec-a2bf-d0013b7e5372)

            - Shall display like portrait mode

**Demo**

![Simulator Screen Recording - iPad Pro 13-inch (M4) - 2024-09-20 at 19 03 59](https://github.com/user-attachments/assets/a0fa5e68-61dc-44f0-b7e3-f1234c0cef10)
