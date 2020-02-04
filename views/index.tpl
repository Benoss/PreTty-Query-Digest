<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/plug-ins/380cb78f450/integration/bootstrap/3/dataTables.bootstrap.css" />
    <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js" ></script>
    <script type="text/javascript" src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js" ></script>
    <script type="text/javascript" src="//cdn.datatables.net/1.10.3/js/jquery.dataTables.min.js" ></script>
    <script type="text/javascript" src="//cdn.datatables.net/plug-ins/380cb78f450/integration/bootstrap/3/dataTables.bootstrap.js" ></script>
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/highlight.js/8.3/styles/default.min.css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/highlight.js/8.3/highlight.min.js"></script>

    <title></title>
    <script type="text/javascript">
        $(document).ready(function(){

            $('#result tfoot th').each( function () {
                var title = $('#result thead th').eq( $(this).index() ).text();
                $(this).html( '<input type="text" placeholder="Search '+title+'" />' );
            } );

            var table = $('#result').DataTable({
                "iDisplayLength": 25
            });

            table.columns().eq( 0 ).each( function ( colIdx ) {
                $( 'input', table.column( colIdx ).footer() ).on( 'keyup change', function () {
                    table
                        .column( colIdx )
                        .search( this.value )
                        .draw();
                } );
            } );

            $('#result tbody').on('click', 'tr', function() {
                var d = table.row( this ).data();
                $("#modal-fingerprint").text($(this).data("fingerprint"));
                hljs.highlightBlock($('#modal-fingerprint').get(0));
                $('#modal-query').text($(this).data("example"));
                hljs.highlightBlock($('#modal-query').get(0));
                $('#modal-rows_examined').text($(this).data("rows_examined"));

                $('#myModal').modal();
            });

            });
    </script>
    <style type="text/css">
body { font-size: 140%; }
.table { table-layout:fixed; }

.table td {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
        input {
            width: 100px;
        }
    </style>
</head>
<body>
<div class="container">

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">More Info</h4>
      </div>
      <div class="modal-body">
          <p id="modal-rows_examined"></p>
          <h4>FingerPrint</h4>
          <pre><code id="modal-fingerprint" class="sql">...</code></pre>
          <h4>Example</h4>
          <pre><code id="modal-query" class="sql">...</code></pre>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
    <h4>Files: {{" ".join([file.get("name") for file in parsed_result.get("global").get("files")])}}</h4>
    <p>
        Total queries parsed {{parsed_result.get("global").get("query_count")}}
        Unique queries {{parsed_result.get("global").get("unique_query_count")}}
    </p>
    <table id="result" class="table table-striped table-bordered" cellspacing="0" width="100%">
        <thead>
            <tr>
                %for key in thead:
                <th>{{key}}</th>
                % end
            </tr>
        </thead>
        <tfoot>
            <tr>
                %for key in thead:
                <th>{{key}}</th>
                % end
            </tr>
        </tfoot>
        <tbody>
        % for row in parsed_result.get("classes"):
            <tr
                    data-fingerprint="{{row.get('fingerprint')}}"
                    data-example="{{row.get('example').get('query')}}"
                    data-first_seen="{{row.get('ts_min')}}"
                    data-last_seen="{{row.get('ts_max')}}"
                    data-rows_examined="{{row.get('Rows_examined')}}"
                    >
                <td>{{row.get("metrics").get("db").get("value")}}</td>
                <td>{{row.get("fingerprint")}}</td>
                <td>{{row.get("query_count")}}</td>
                <td>{{row.get("metrics").get("Query_time").get("median")}}</td>
                <td>{{row.get("metrics").get("Query_time").get("pct_95")}}</td>
                <td>{{row.get("metrics").get("Query_time").get("sum")}}</td>
                <td>{{row.get("metrics").get("Rows_examined").get("median")}}</td>
                <td>{{row.get("metrics").get("Lock_time").get("median")}}</td>

            </tr>
        % end
        </tbody>
    </table>
</div>
</body>
</html>