package main

# Deny if any created or updated namespace lacks the restricted PSS label
deny contains msg if {
    some resource in input.resource_changes
    resource.type == "kubernetes_namespace_v1"

    valid_action(resource.change.actions)

    labels := object.get(resource.change.after.metadata[0], "labels", {})
    not valid_pss_label(labels)

    msg := sprintf("Security Violation: Namespace '%v' must strictly enforce 'pod-security.kubernetes.io/enforce=restricted'", [resource.change.after.metadata[0].name])
}

valid_action(actions) if {
    actions[_] == "create"
}
valid_action(actions) if {
    actions[_] == "update"
}

valid_pss_label(labels) if {
    labels["pod-security.kubernetes.io/enforce"] == "restricted"
}
