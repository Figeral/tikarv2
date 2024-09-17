import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class PaginatedSortableTable extends StatefulWidget {
  final List<DataItem> data;

  const PaginatedSortableTable({super.key, required this.data});

  @override
  _PaginatedSortableTableState createState() => _PaginatedSortableTableState();
}

class _PaginatedSortableTableState extends State<PaginatedSortableTable> {
  int _rowsPerPage = 10;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  late List<DataItem> _sortedData;
  int _currentPage = 0;
  String _searchQuery = '';
  bool _showActiveOnly = false;
  int? _hoveredIndex;

  @override
  void initState() {
    super.initState();
    _sortedData = List.from(widget.data);
    _sortData();
  }

  void _sortData() {
    _sortedData.sort((a, b) {
      switch (_sortColumnIndex) {
        case 0:
          return _sortAscending
              ? a.name.compareTo(b.name)
              : b.name.compareTo(a.name);
        case 1:
          return _sortAscending
              ? a.number.compareTo(b.number)
              : b.number.compareTo(a.number);
        case 2:
          return _sortAscending
              ? a.isActive.toString().compareTo(b.isActive.toString())
              : b.isActive.toString().compareTo(a.isActive.toString());
        case 3:
          return _sortAscending
              ? a.date.compareTo(b.date)
              : b.date.compareTo(a.date);
        default:
          return 0;
      }
    });
  }

  void _filterData() {
    _sortedData = widget.data.where((item) {
      bool matchesSearch =
          item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              item.number.toString().contains(_searchQuery);
      bool matchesActiveFilter = !_showActiveOnly || item.isActive;
      return matchesSearch && matchesActiveFilter;
    }).toList();
    _sortData();
    _currentPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    int totalPages = (_sortedData.length / _rowsPerPage).ceil();
    int startIndex = _currentPage * _rowsPerPage;
    int endIndex = (startIndex + _rowsPerPage).clamp(0, _sortedData.length);
    List<DataItem> pageData = _sortedData.sublist(startIndex, endIndex);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'Search',
              suffixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
                _filterData();
              });
            },
          ),
        ),
        Row(
          children: [
            Checkbox(
              value: _showActiveOnly,
              onChanged: (value) {
                setState(() {
                  _showActiveOnly = value!;
                  _filterData();
                });
              },
            ),
            const Text('Show Active Only'),
          ],
        ),
        PaginatedDataTable(
          header: const Text('Paginated and Sortable Table'),
          columns: [
            DataColumn(
              label: const Text('Name'),
              onSort: (columnIndex, ascending) {
                setState(() {
                  _sortColumnIndex = columnIndex;
                  _sortAscending = ascending;
                  _sortData();
                });
              },
            ),
            DataColumn(
              label: const Text('Number'),
              numeric: true,
              onSort: (columnIndex, ascending) {
                setState(() {
                  _sortColumnIndex = columnIndex;
                  _sortAscending = ascending;
                  _sortData();
                });
              },
            ),
            DataColumn(
              label: const Text('Active'),
              onSort: (columnIndex, ascending) {
                setState(() {
                  _sortColumnIndex = columnIndex;
                  _sortAscending = ascending;
                  _sortData();
                });
              },
            ),
            DataColumn(
              label: const Text('Date'),
              onSort: (columnIndex, ascending) {
                setState(() {
                  _sortColumnIndex = columnIndex;
                  _sortAscending = ascending;
                  _sortData();
                });
              },
            ),
          ],
          source: _DataSource(pageData, (index) {
            setState(() {
              _hoveredIndex = index;
            });
          }, _hoveredIndex),
          rowsPerPage: _rowsPerPage,
          onRowsPerPageChanged: (value) {
            setState(() {
              _rowsPerPage = value!;
              _currentPage = 0;
            });
          },
          availableRowsPerPage: const [5, 10, 15, 20],
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: _currentPage > 0
                  ? () {
                      setState(() {
                        _currentPage--;
                      });
                    }
                  : null,
            ),
            Text('${_currentPage + 1} / $totalPages'),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: _currentPage < totalPages - 1
                  ? () {
                      setState(() {
                        _currentPage++;
                      });
                    }
                  : null,
            ),
          ],
        ),
      ],
    );
  }
}

class _DataSource extends DataTableSource {
  final List<DataItem> _data;
  final Function(int?) onHover;
  final int? hoveredIndex;

  _DataSource(this._data, this.onHover, this.hoveredIndex);

  @override
  DataRow getRow(int index) {
    final item = _data[index];
    return DataRow(
      onSelectChanged: (value) => print(item.name),
      color: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (index == hoveredIndex) {
            return Colors.grey.withOpacity(0.1);
          }
          return null;
        },
      ),
      cells: [
        DataCell(Text(item.name)),
        DataCell(Text(item.number.toString())),
        DataCell(Text(item.isActive ? 'Yes' : 'No')),
        DataCell(Text(DateFormat('yyyy-MM-dd').format(item.date))),
      ],
      // onHover: (isHovered) {
      //   onHover(isHovered ? index : null);
      // },
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}

class DataItem {
  final String name;
  final int number;
  final bool isActive;
  final DateTime date;

  DataItem(
      {required this.name,
      required this.number,
      required this.isActive,
      required this.date});
}
