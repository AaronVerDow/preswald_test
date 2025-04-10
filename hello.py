from preswald import text, plotly, connect, get_df, table
import pandas as pd
import plotly.express as px

connect() # load in all sources, which by default is the sample_csv
data = get_df('traffic_csv')

data["START_LATITUDE"] = pd.to_numeric(data["START_LATITUDE"], errors="coerce")
data["START_LONGITUDE"] = pd.to_numeric(data["START_LONGITUDE"], errors="coerce")
data["CURRENT_SPEED"] = pd.to_numeric(data["CURRENT_SPEED"], errors="coerce")

# table(data)

def draw_map(name, data):
    text(f"# {name}")

    start_lat = data["START_LATITUDE"].mean()
    start_lon = data["START_LONGITUDE"].mean()
    start_scale = 250

    map=px.scatter_geo(
            data,
            lat="START_LATITUDE",
            lon="START_LONGITUDE",
            color="CURRENT_SPEED",
            # size="CURRENT_SPEED",
            hover_name="STREET",
            basemap_visible=True
    )

    map.update_geos(
        center=dict(lat=start_lat, lon=start_lon),
        projection_scale=start_scale,  
        scope="north america" 
    )
    plotly(map)

def street_map(street_name):
    street_data = data[data["STREET"] == street_name]
    draw_map(f"{street_name} Traffic Speeds", street_data)

draw_map("Chicago Traffic Speeds", data)
street_map("Elston")
street_map("Touhy")
