import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:tikar/utils/app_colors.dart';
import 'package:tikar/models/staff_model.dart';
import 'package:tikar/extensions/extensions.dart';

class StaffPaginatedSortableTable extends StatefulWidget {
  final List<StaffModel?> data;

  const StaffPaginatedSortableTable({super.key, required this.data});

  @override
  _StaffPaginatedSortableTableState createState() =>
      _StaffPaginatedSortableTableState();
}

class _StaffPaginatedSortableTableState
    extends State<StaffPaginatedSortableTable> {
  int _rowsPerPage = 10;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  late List<StaffModel> _sortedData;
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
              ? a.fname.compareTo(b.fname)
              : b.fname.compareTo(a.fname);
        case 1:
          return _sortAscending
              ? a.lname.compareTo(b.lname)
              : b.lname.compareTo(a.lname);
        case 2:
          return _sortAscending
              ? a.role[0].compareTo(b.role[0])
              : b.role[0].compareTo(a.role[0]);
        case 3:
          return _sortAscending
              ? a.post!.compareTo(b.post!)
              : b.post!.compareTo(a.post!);
        case 4:
          return _sortAscending
              ? a.active.toString().compareTo(b.active.toString())
              : b.active.toString().compareTo(a.active.toString());
        default:
          return 0;
      }
    });
  }

  void _filterData() {
    _sortedData = widget.data
        .where((item) {
          if (item == null) return false; // Skip null items

          final lowercaseQuery = _searchQuery.toLowerCase();

          bool matchesSearch = item.fname
                  .toLowerCase()
                  .contains(lowercaseQuery) ||
              item.lname.toLowerCase().contains(lowercaseQuery) ||
              (item.post?.toLowerCase().contains(lowercaseQuery) ?? false) ||
              item.role
                  .any((role) => role.toLowerCase().contains(lowercaseQuery));

          bool matchesActiveFilter = !_showActiveOnly || item.active;

          return matchesSearch && matchesActiveFilter;
        })
        .whereType<StaffModel>()
        .toList();

    _sortData();
    _currentPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    int totalPages = (_sortedData.length / _rowsPerPage).ceil();
    int startIndex = _currentPage * _rowsPerPage;
    int endIndex = (startIndex + _rowsPerPage).clamp(0, _sortedData.length);
    List<StaffModel> pageData = _sortedData.sublist(startIndex, endIndex);

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
        Container(
          width: context.width,
          child: Theme(
            data: Theme.of(context).copyWith(
              dataTableTheme: DataTableThemeData(
                headingRowColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                  return Colors.transparent;
                }),
                dataRowColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                  return Colors.transparent;
                }),
              ),
            ),
            child: PaginatedDataTable(
              header: const Text(
                'Donnees des Employee',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              columns: [
                DataColumn(
                  label: const Text('Pnoms'),
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      _sortColumnIndex = columnIndex;
                      _sortAscending = ascending;
                      _sortData();
                    });
                  },
                ),
                DataColumn(
                  label: const Text('Noms'),
                  // numeric: true,
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      _sortColumnIndex = columnIndex;
                      _sortAscending = ascending;
                      _sortData();
                    });
                  },
                ),
                DataColumn(
                  label: const Text('Poste'),
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      _sortColumnIndex = columnIndex;
                      _sortAscending = ascending;
                      _sortData();
                    });
                  },
                ),
                DataColumn(
                  label: const Text('Role'),
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      _sortColumnIndex = columnIndex;
                      _sortAscending = ascending;
                      _sortData();
                    });
                  },
                ),
                DataColumn(
                  label: const Text('Actif'),
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
          ),
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
  final List<StaffModel> _data;
  final Function(int?) onHover;
  final int? hoveredIndex;

  _DataSource(this._data, this.onHover, this.hoveredIndex);

  @override
  DataRow getRow(int index) {
    final item = _data[index];
    return DataRow(
      onSelectChanged: (value) => print(item.fname),
      color: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (index == hoveredIndex) {
            return Colors.grey.withOpacity(0.1);
          }
          return null;
        },
      ),
      cells: [
        DataCell(Text(item.fname)),
        DataCell(Text(item.lname)),
        DataCell(Text(item.post ?? "vacan")),
        DataCell(Text(item.role[0])),
        DataCell(Text(item.active ? 'Yes' : 'No')),
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
