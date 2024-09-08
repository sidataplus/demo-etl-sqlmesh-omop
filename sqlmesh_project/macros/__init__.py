from sqlmesh import macro

@macro()
def map_running_id(evaluator, source_id):
    return f"ROW_NUMBER() OVER (ORDER BY {source_id})"