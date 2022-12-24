Attribute VB_Name = "Module11"
Sub stock_exercise():

    'Loop through sheets in the workbook, performing code on each one; begins with "For i", ends with "Next i"
        ' This for loop will wrap everything
    
    Dim sheet_count As Integer
    Dim i As Integer
    
    sheet_count = ActiveWorkbook.Worksheets.Count
    For i = 1 To sheet_count
            
        ' Counts rows used in each Worksheet, one at a time, and saves that number as last_row
        Dim last_row As Long
        last_row = Worksheets(i).UsedRange.Rows.Count
        
        ' Sorts each sheet in the excel by ticker and then date, to make sure the sorting/order is correct, just in case
        Worksheets(i).Columns.Sort key1:=Worksheets(i).Columns("A"), Order1:=xlAscending, Key2:=Worksheets(i).Columns("B"), Order2:=xlAscending, Header:=xlYes
              
        ' Sets up output columns, for each worksheet
        Worksheets(i).Cells(1, 9).Value = "Ticker"
        Worksheets(i).Cells(1, 10).Value = "Yearly Change"
        Worksheets(i).Cells(1, 11).Value = "Percent Change"
        Worksheets(i).Cells(1, 12).Value = "Total Stock Volume"
        Worksheets(i).Cells(1, 15).Value = "Ticker"
        Worksheets(i).Cells(1, 16).Value = "Value"
        Worksheets(i).Cells(2, 14).Value = "Greatest % Increase"
        Worksheets(i).Cells(3, 14).Value = "Greatest % Decrease"
        Worksheets(i).Cells(4, 14).Value = "Greatest Total Volume"
        

        ' Track where ticker starts and ends, for each ticker in a sheet
            ' This wraps the code to run on each ticker group, and should populate the yearly change, percent change, and stock volume columns
            ' Long instead of Integer because I don't know how big the actual dataset is
        Dim ticker_start As Long
        Dim ticker_end As Long
        Dim counter As Long
        
        counter = 1

        For tracker = 2 To last_row
            ticker_start = tracker
            While Worksheets(i).Cells(ticker_start, 1).Value = Worksheets(i).Cells(tracker, 1).Value
                tracker = tracker + 1
            Wend
            tracker = tracker - 1
            ticker_end = tracker
            
            ' Now we need code to grab values from start and end of year (ie ticker start and end)
                ' Need a counter to keep track of where the info has to be written
            counter = counter + 1
            
            ' Assign values to variables
            Dim ticker_value As String
            Dim yearly_change As Double
            Dim percent_change As Double
            Dim total_stock_volume As LongLong
            
            ' Ticker value
            ticker_value = Worksheets(i).Cells(ticker_start, 1).Value
            Worksheets(i).Cells(counter, 9).Value = ticker_value
            
            ' Yearly Change
            yearly_change = Worksheets(i).Cells(ticker_end, 6).Value - Worksheets(i).Cells(ticker_start, 3).Value
            Worksheets(i).Cells(counter, 10).Value = yearly_change
            
            ' Percent Change
            percent_change = Worksheets(i).Cells(counter, 10).Value / Worksheets(i).Cells(ticker_start, 3).Value
            Worksheets(i).Cells(counter, 11).Value = FormatPercent(percent_change, 2)
            
            ' Total stock volume
            total_stock_volume = WorksheetFunction.Sum(Range(Worksheets(i).Cells(ticker_start, 7), Worksheets(i).Cells(ticker_end, 7)))
            Worksheets(i).Cells(counter, 12).Value = total_stock_volume
            
        Next tracker
                    
        ' Sets up conditional formatting on Yearly Change column; this will be at the end, after that column is populated
            ' Green for increase
            ' Red for decrease
            ' Grey for no change
        For Each cell In Worksheets(i).Range(Worksheets(i).Range("J2"), Worksheets(i).Range("J2").End(xlDown))
            If cell.Value > 0 Then
                cell.Interior.ColorIndex = 4
            ElseIf cell.Value < 0 Then
                cell.Interior.ColorIndex = 3
            Else
                cell.Interior.ColorIndex = 15
            End If
            cell.NumberFormat = "0.00"
        Next cell
        
        
        'Sets up conditional formatting on Percent Change column
        For Each cell In Worksheets(i).Range(Worksheets(i).Range("K2"), Worksheets(i).Range("K2").End(xlDown))
            If cell.Value > 0 Then
                cell.Interior.ColorIndex = 4
            ElseIf cell.Value < 0 Then
                cell.Interior.ColorIndex = 3
            Else
                cell.Interior.ColorIndex = 15
            End If
        Next cell
        
        ' Now to grab bonus stats: Greatest % increase and decrease, and greatest total volume
            ' Look for required max/min of each summary column
        ' Defines last used column for summaries
        Dim last_row_summary As Long
        With Worksheets(i)
            last_row_summary = .Cells(.Rows.Count, "K").End(xlUp).Row
        End With
        
        ' Grabs bonus stats - values
        Dim percent_increase As Double
        Dim percent_decrease As Double
        Dim total_stock As LongLong
        
        ' Percent increase
        percent_increase = WorksheetFunction.Max(Range(Worksheets(i).Cells(2, 11), Worksheets(i).Cells(last_row_summary, 11)))
        
        ' Percent decrease
        percent_decrease = WorksheetFunction.Min(Range(Worksheets(i).Cells(2, 11), Worksheets(i).Cells(last_row_summary, 11)))
        
        ' Total stock volume
        total_stock = WorksheetFunction.Max(Range(Worksheets(i).Cells(2, 12), Worksheets(i).Cells(last_row_summary, 12)))
        
        'Find the ticker for each summary value
        Dim row_increase As Integer
        Dim row_decrease As Integer
        Dim row_total As Integer
        
        row_increase = WorksheetFunction.Match(percent_increase, Range(Worksheets(i).Cells(1, 11), Worksheets(i).Cells(last_row_summary, 11)), 0)
        row_decrease = WorksheetFunction.Match(percent_decrease, Range(Worksheets(i).Cells(1, 11), Worksheets(i).Cells(last_row_summary, 11)), 0)
        row_total = WorksheetFunction.Match(total_stock, Range(Worksheets(i).Cells(1, 12), Worksheets(i).Cells(last_row_summary, 12)), 0)
           
        
        ' Assign all the bonus values and tickers
        
        Worksheets(i).Cells(2, 15).Value = Worksheets(i).Cells(row_increase, 9)
        Worksheets(i).Cells(3, 15).Value = Worksheets(i).Cells(row_decrease, 9)
        Worksheets(i).Cells(4, 15).Value = Worksheets(i).Cells(row_total, 9)
        Worksheets(i).Cells(2, 16).Value = FormatPercent(percent_increase)
        Worksheets(i).Cells(3, 16).Value = FormatPercent(percent_decrease)
        Worksheets(i).Cells(4, 16).Value = total_stock
        
    Next i
    
End Sub
