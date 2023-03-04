#################################################
# Imports
#################################################

import numpy as np
import datetime as dt

import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func

from flask import Flask, jsonify

#################################################
# Database Setup
#################################################
engine = create_engine("sqlite:///Resources/hawaii.sqlite")

# reflect an existing database into a new model
Base = automap_base()
# reflect the tables
Base.prepare(engine, reflect=True)

# Save references to the tables
Measurement = Base.classes.measurement
Station = Base.classes.station

#################################################
# Flask Setup
#################################################
app = Flask(__name__)

#################################################
# Flask Routes
#################################################

@app.route("/")
def home():
    print("Homepage has been accessed")
    return (
            f"Welcome to the Hawaii weather API<br/>"
            f"Available paths:<br/>"
            f"/api/v1.0/precipitation<br/>"
            f"• Returns the last 12 months of precipitation data, one datapoint per date<br/>"
            f"/api/v1.0/precipitation_full<br/>"
            f"• Returns the last 12 months of precipitation data, all datapoints per date; also returns station<br/>"
            f"/api/v1.0/stations<br/>"
            f"• Returns a list of stations, with all attributes reported<br/>"
            f"/api/v1.0/tobs<br/>"
            f"• Returns a list of temperature observations and the date they were taken for the previous year from the most active station<br/>"
            f"/api/v1.0/start_date<br/>"
            f"• Returns a list of minimum, maximum, and average temperature for the specified start to the latest date inclusive<br/>"
            f"/api/v1.0/start_date/end_date<br/>"
            f"• Returns a list of minimum, maximum, and average temperature for the dates between the specified start and end dates inclusive<br/>"
    )

@app.route("/api/v1.0/precipitation")
def precipitation():
    print("Precipitation page of Hawaii weather API has been accessed")
    
    # Start a session
    session = Session(engine)
    # Query for precipitation data for the last year
    # NOTE: The way this query is formatted, only ONE value per date is retained, the last value
    ## because the dates are keys and every key must be unique
    ## Therefore this is missing data for each date
    data = session.query(Measurement.date, Measurement.prcp).filter(Measurement.date >= "2016-08-23").order_by(Measurement.date).all()
    # Close the session
    session.close()

    # Converts query results to dictionary
    data_dict = {}
    for date, station in data:
        data_dict[date] = station

    # Returns json
    return jsonify(data_dict)

@app.route("/api/v1.0/precipitation_full")
def precipitation_full():
    print("Precipitation_full page of Hawaii weather API has been accessed")
    
    # Start a session
    session = Session(engine)
    # Query for data on precipitaion for the last year
    data = session.query(Measurement.station, Measurement.date, Measurement.prcp).filter(Measurement.date >= "2016-08-23").order_by(Measurement.date).all()
    # Close the session
    session.close()

    # Converts query results to list of dictionaries
    data_formatted = []
    for station, date, measurement in data:
        data_dict = {}
        data_dict['station'] = station
        data_dict['date'] = date
        data_dict['measurement'] = measurement
        data_formatted.append(data_dict)

    # Returns json
    return jsonify(data_formatted)

@app.route("/api/v1.0/stations")
def stations():
    print("Stations page of Hawaii weather API has been accessed")

    # Start a session
    session = Session(engine)
    # Query for all information on each Station
    data = session.query(Station.station, Station.name, Station.latitude, Station.longitude, Station.elevation).all()
    # Close the session
    session.close()

    # Converts query results to a list of dictionaries
    data_formatted = []
    for station, name, latitude, longitude, elevation in data:
        data_dict = {}
        data_dict['station'] = station
        data_dict['name'] = name
        data_dict['latitude'] = latitude
        data_dict['longitude'] = longitude
        data_dict['elevation'] = elevation
        data_formatted.append(data_dict)

    # Returns json
    return jsonify(data_formatted)

@app.route("/api/v1.0/tobs")
def tobs():
    print("Tobs page of Hawaii weather API has been accessed")

    # Start a session
    session = Session(engine)
    # Query for dates and temps of the most active station over the last year
    data = session.query(Measurement.date, Measurement.tobs).filter(Measurement.station == "USC00519281", Measurement.date >= "2016-08-23").order_by(Measurement.date).all()
    # Close the session
    session.close()

    # Converts the query to a list of dictionaries
    data_formatted = []
    for date, tobs in data:
        data_dict = {}
        data_dict['Date'] = date
        data_dict['Temp'] = tobs
        data_formatted.append(data_dict)

    # Returns json
    return jsonify(data_formatted)

@app.route("/api/v1.0/<start_date>")
def start(start_date):
    print("Start page of Hawaii weather API has been accessed")

    try:
        # Formats the input date properly
        start_formatted = dt.date(int(start_date[:4]), int(start_date[4:6]), int(start_date[6:]))

        # Start a session
        session = Session(engine)
        # Query for min, max, and average temp data from specified start date to the latest date
        data = session.query(func.min(Measurement.tobs),\
                                func.max(Measurement.tobs),\
                                func.avg(Measurement.tobs)).\
                    filter(Measurement.date >= start_formatted).all()
        # Close the session
        session.close()

        # Formats the query output into a dictionary
        results_dict = {}
        for min, max, avg in data:
            results_dict['Minimum Temp'] = min
            results_dict['Maximum Temp'] = max
            results_dict['Average Temp'] = round(avg, 2)
        
        # Returns json
        return jsonify(results_dict)

    except:
        return jsonify({"error": f"Start date not found. Please enter a date in the format 'YYYMMDD' between 2010-01-01 and 2017-08-23"}), 404

@app.route("/api/v1.0/<start_date>/<end_date>")
def start_end(start_date, end_date):
    print("Start/ End page of Hawaii weather API has been accessed")

    try:
        # Formats the input dates properly
        start_formatted = dt.date(int(start_date[:4]), int(start_date[4:6]), int(start_date[6:]))
        end_formatted = dt.date(int(end_date[:4]), int(end_date[4:6]), int(end_date[6:]))

        # Start a session
        session = Session(engine)
        # Query for min, max, and average temp data from specified start date to the specified end date
        data = session.query(func.min(Measurement.tobs),\
                                func.max(Measurement.tobs),\
                                func.avg(Measurement.tobs)).\
                    filter(Measurement.date >= start_formatted, Measurement.date <= end_formatted).all()
        # Close the session
        session.close()

        # Formats the query output into a dictionary
        results_dict = {}
        for min, max, avg in data:
            results_dict['Minimum Temp'] = min
            results_dict['Maximum Temp'] = max
            results_dict['Average Temp'] = round(avg, 2)
        
        # Returns json
        return jsonify(results_dict)

    except:
        return jsonify({"error": f"Dates not found. Please enter start and end dates in the format 'YYYMMDD' between 2010-01-01 and 2017-08-23"}), 404


#################################################
# Run the App
#################################################

if __name__ == '__main__':
    app.run(debug=True)