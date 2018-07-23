# Datagram for state store
static func state_for(entity):
    return [entity.position , entity.enabled, entity.get_node('Sprite').animation]
    
static func delta_entity(entity, delta):
    var _e = state_for(entity)
    # sets delta
    _e[0] = delta
    return _e

# delta for state 
static func get_delta(a, b):
    return b - a 

# applies delta
# (return to eliminate pointer semantics)
static func apply_delta(position, delta):
    return position - delta

