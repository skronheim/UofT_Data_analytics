Attribute VB_Name = "VBAchallengeSK"
Sub vbaChallenge():

    'Loop through sheets in the workbook, performing code on each one; begins with "For i", ends with "Next i"
        ' This for loop will wrap everything
        ' Starts by figuring out how many sheets there are
    
    Dim sheet_count As Integer
    Dim i As Integer
    
    sheet_count = ActiveWorkbook.Worksheets.Count
    For i = 1 To sheet_count
            
        ' Counts rows used in each Worksheet, one at a time, and saves that number as last_row
        Dim last_row As Long
        last_row = Worksheets(i).UsedRange.Rows.Count
        
        ' Sorts each sheet in the excel by ticker and then date, to make sure the sorting/order is correct, just in case
        Worksheets(i).Columns.Sort key1:=Worksheets(i).Columns("A"), Order1:=xlAscending, Key2:=Worksheets(i).Columns("B"), Order2:=xlAscending, Header:=xlYes
              
        ' Retrieves data for ticker symbol, volume of stock, open price, and close price for each worksheet, one at a time, and saves to variables
        Dim ticker_symbol As Range
        Dim volume_of_stock As Range
        Dim open_price As Range
        Dim close_price As Range
        
        Set ticker_symbol = Worksheets(i).Range(Worksheets(i).Cells(2, 1), Worksheets(i).Cells(last_row, 1))
        Set volume_of_stock = Worksheets(i).Range(Worksheets(i).Cells(2, 7), Worksheets(i).Cells(last_row, 7))
        Set open_price = Worksheets(i).Range(Worksheets(i).Cells(2, 3), Worksheets(i).Cells(last_row, 3))
        Set close_price = Worksheets(i).Range(Worksheets(i).Cells(2, 6), Worksheets(i).Cells(last_row, 6))
        
        ' Sets up output variables as Range, for each worksheet
            ' Initializes variables
        Dim ticker_column As Range
        Dim yearly_change_column As Range
        Dim percent_change_column As Range
        Dim total_stock_volume_column As Range
        
            ' Assigns specific ranges (columns) to output variables
        Set ticker_column = Worksheets(i).Range(Worksheets(i).Cells(1, 9), Worksheets(i).Cells(last_row, 9))
        Set yearly_change_column = Worksheets(i).Range(Worksheets(i).Cells(1, 10), Worksheets(i).Cells(last_row, 10))
        Set percent_change_column = Worksheets(i).Range(Worksheets(i).Cells(1, 11), Worksheets(i).Cells(last_row, 11))
        Set total_stock_volumn_column = Worksheets(i).Range(Worksheets(i).Cells(1, 12), Worksheets(i).Cells(last_row, 12))
        
            ' Labels first row in each column with what the column shows
        ticker_column.Rows(1).Value = "Ticker"
        yearly_change_column.Rows(1).Value = "Yearly Change"
        percent_change_column.Rows(1).Value = "Percent Change"
        total_stock_volumn_column.Rows(1).Value = "Total Stock Volume"
        
        
        ' Populates newly created columns:
            ' Track where ticker starts and ends, for each ticker in a sheet
            ' This wraps the code to run on each ticker group, and should populate the yearly change, percent change, and stock volume columns
            ' Long instead of Integer because I don't know how big the actual dataset is
        Dim ticker_start As Long
        Dim ticker_end As Long
        Dim counter As Long
        Dim tracker As Long
        
        counter = 1

        For tracker = 1 To last_row - 1
            ticker_start = tracker
            Do While ticker_symbol.Rows(ticker_start).Value = ticker_symbol.Rows(tracker).Value
                tracker = tracker + 1
            Loop
            tracker = tracker - 1
            ticker_end = tracker
            
            ' Now we need code to grab values from start and end of year (ie ticker start and end)
                ' Need a counter to keep track of where the info has to be written
            counter = counter + 1
            
            ' Assign values to variables
            Dim total_stock_volume As LongLong
            
            ' Ticker value
            ticker_column.Rows(counter).Value = ticker_symbol.Rows(ticker_start).Value
            
            ' Yearly Change
            yearly_change_column.Rows(counter).Value = close_price.Rows(ticker_end).Value - open_price.Rows(ticker_start).Value
            
            ' Percent Change
            percent_change_column.Rows(counter).Value = FormatPercent(yearly_change_column.Rows(counter).Value / open_price.Rows(ticker_start).Value, 2)
            
            ' Total stock volume
            total_stock_volumn_column.Rows(counter).Value = WorksheetFunction.Sum(Range(volume_of_stock.Rows(ticker_start), volume_of_stock.Rows(ticker_end)))
            
        Next tracker
        
        ' Sets up conditional formatting on Yearly Change column; this will be at the end, after that column is populated
            ' Green for increase
            ' Red for decrease
            ' Grey for no change
        For Each cell In yearly_change_column
            If cell.Value = "Yearly Change" Then
            ElseIf cell.Value > 0 Then
                cell.Interior.ColorIndex = 4
            ElseIf cell.Value < 0 Then
                cell.Interior.ColorIndex = 3
            ElseIf IsEmpty(cell.Value) Then
            ElseIf cell.Value = 0 Then
                cell.Interior.ColorIndex = 15
            End If
            cell.NumberFormat = "0.00"
        Next cell
        
        
        'Sets up conditional formatting on Percent Change column
        For Each cell In percent_change_column
            If cell.Value = "Percent Change" Then
            ElseIf cell.Value > 0 Then
                cell.Interior.ColorIndex = 4
            ElseIf cell.Value < 0 Then
                cell.Interior.ColorIndex = 3
            ElseIf IsEmpty(cell.Value) Then
            ElseIf cell.Value = 0 Then
                cell.Interior.ColorIndex = 15
            End If
        Next cell
        
        ' Now to grab bonus stats: Greatest % increase and decrease, and greatest total volume
            ' Look for required max/min of each summary column
            
            ' Sets up calculated summary stat table
        Worksheets(i).Cells(1, 15).Value = "Ticker"
        Worksheets(i).Cells(1, 16).Value = "Value"
        Worksheets(i).Cells(2, 14).Value = "Greatest % Increase"
        Worksheets(i).Cells(3, 14).Value = "Greatest % Decrease"
        Worksheets(i).Cells(4, 14).Value = "Greatest Total Volume"

            ' Grabs bonus stats - values
        Dim percent_increase As Double
        Dim percent_decrease As Double
        Dim total_stock As LongLong
        
            ' Percent increase
        percent_increase = WorksheetFunction.Max(percent_change_column)
        
            ' Percent decrease
        percent_decrease = WorksheetFunction.Min(percent_change_column)
        
            ' Total stock volume
        total_stock = WorksheetFunction.Max(total_stock_volumn_column)
        
            'Find the ticker for each summary value
        Dim row_increase As Integer
        Dim row_decrease As Integer
        Dim row_total As Integer
        
        row_increase = WorksheetFunction.Match(percent_increase, percent_change_column, 0)
        row_decrease = WorksheetFunction.Match(percent_decrease, percent_change_column, 0)
        row_total = WorksheetFunction.Match(total_stock, total_stock_volumn_column, 0)
           
        
            ' Assign all the bonus values and tickers
        
        Worksheets(i).Cells(2, 15).Value = Worksheets(i).Cells(row_increase, 9)
        Worksheets(i).Cells(3, 15).Value = Worksheets(i).Cells(row_decrease, 9)
        Worksheets(i).Cells(4, 15).Value = Worksheets(i).Cells(row_total, 9)
        Worksheets(i).Cells(2, 16).Value = FormatPercent(percent_increase)
        Worksheets(i).Cells(3, 16).Value = FormatPercent(percent_decrease)
        Worksheets(i).Cells(4, 16).Value = total_stock
        
    Next i
    
End Sub
