import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:tikar/utils/app_colors.dart';
import 'package:tikar/models/asset_model.dart';
import 'package:tikar/models/staff_model.dart';
import 'package:tikar/models/lessor_model.dart';
import 'package:tikar/extensions/extensions.dart';

class AssetPaginatedSortableTable extends StatefulWidget {
  final List<AssetModel?> data;

  const AssetPaginatedSortableTable({super.key, required this.data});

  @override
  _AssetPaginatedSortableTableState createState() =>
      _AssetPaginatedSortableTableState();
}

class _AssetPaginatedSortableTableState
    extends State<AssetPaginatedSortableTable> {
  int _rowsPerPage = 10;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  late List<AssetModel> _sortedData;
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
              ? a.matricule!.compareTo(b.matricule!)
              : b.matricule!.compareTo(a.matricule!);
        case 1:
          return _sortAscending
              ? a.assetType!.compareTo(b.assetType!)
              : b.assetType!.compareTo(a.assetType!);
        case 2:
          return _sortAscending
              ? a.lessor.fname.compareTo(b.lessor.fname)
              : b.lessor.fname.compareTo(a.lessor.fname);
        case 3:
          return _sortAscending
              ? a.addedBy!.fname.compareTo(b.addedBy!.fname)
              : b.addedBy!.fname.compareTo(a.addedBy!.fname);
        case 4:
          return _sortAscending
              ? a.ville.toString().compareTo(b.ville.toString())
              : b.ville.toString().compareTo(a.ville.toString());
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

          bool matchesSearch = item.matricule!
                  .toLowerCase()
                  .contains(lowercaseQuery) ||
              item.assetType!.toLowerCase().contains(lowercaseQuery) ||
              (item.addedBy!.fname.toLowerCase().contains(lowercaseQuery)) ||
              item.ville!.toLowerCase().contains(lowercaseQuery);

          bool matchesActiveFilter = !_showActiveOnly || item.isActive;

          return matchesSearch && matchesActiveFilter;
        })
        .whereType<AssetModel>()
        .toList();

    _sortData();
    _currentPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    int totalPages = (_sortedData.length / _rowsPerPage).ceil();
    int startIndex = _currentPage * _rowsPerPage;
    int endIndex = (startIndex + _rowsPerPage).clamp(0, _sortedData.length);
    List<AssetModel> pageData = _sortedData.sublist(startIndex, endIndex);

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
                'Donnees des Bailleurs',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              columns: [
                DataColumn(
                  label: const Text('Matricule'),
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      _sortColumnIndex = columnIndex;
                      _sortAscending = ascending;
                      _sortData();
                    });
                  },
                ),
                DataColumn(
                  label: const Text('Type'),
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
                  label: const Text('Propriétaire/Bailleur'),
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      _sortColumnIndex = columnIndex;
                      _sortAscending = ascending;
                      _sortData();
                    });
                  },
                ),
                DataColumn(
                  label: const Text('Ajouter Par'),
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      _sortColumnIndex = columnIndex;
                      _sortAscending = ascending;
                      _sortData();
                    });
                  },
                ),
                DataColumn(
                  label: const Text('Address'),
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
  final List<AssetModel> _data;
  final Function(int?) onHover;
  final int? hoveredIndex;

  _DataSource(this._data, this.onHover, this.hoveredIndex);

  @override
  DataRow getRow(int index) {
    final item = _data[index];
    return DataRow(
      onSelectChanged: (value) => print(item.matricule),
      color: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (index == hoveredIndex) {
            return Colors.grey.withOpacity(0.1);
          }
          return null;
        },
      ),
      cells: [
        DataCell(Text(item.matricule!)),
        DataCell(Text(item.assetType!)),
        DataCell(Text("${item.lessor!.fname} " + " ${item.lessor!.lname}")),
        DataCell(Text("${item.addedBy!.fname} " + " ${item.addedBy!.lname}")),
        DataCell(Text("${item.ville} ," + " ${item.address}")),
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
